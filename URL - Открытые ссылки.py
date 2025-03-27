import requests
from urllib.parse import urljoin, urlparse
from bs4 import BeautifulSoup
import time
from collections import deque

def is_valid_url(url):
    """Проверяет, является ли URL допустимым"""
    parsed = urlparse(url)
    return bool(parsed.netloc) and bool(parsed.scheme)

def normalize_url(base_url, link):
    """Преобразует относительные ссылки в абсолютные"""
    if link.startswith('http'):
        return link
    return urljoin(base_url, link)

def web_crawler(start_url, max_pages=10, delay=1):
    """
    Улучшенный веб-краулер с ограничением глубины и задержкой
    
    :param start_url: Начальный URL для обхода
    :param max_pages: Максимальное количество страниц для посещения
    :param delay: Задержка между запросами (в секундах)
    :return: Словарь {URL: [найденные_ссылки]}
    """
    visited = set()
    to_visit = deque([start_url])
    result = {}
    session = requests.Session()
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    }
    
    while to_visit and len(visited) < max_pages:
        current_url = to_visit.popleft()
        
        if current_url in visited:
            continue
            
        try:
            time.sleep(delay)  # Задержка между запросами
            response = session.get(current_url, headers=headers, timeout=10)
            response.raise_for_status()
            
            if 'text/html' not in response.headers.get('Content-Type', ''):
                continue
                
            soup = BeautifulSoup(response.text, 'html.parser')
            links = []
            
            for link in soup.find_all('a', href=True):
                absolute_url = normalize_url(current_url, link['href'])
                if is_valid_url(absolute_url):
                    links.append(absolute_url)
                    if absolute_url not in visited:
                        to_visit.append(absolute_url)
            
            result[current_url] = links
            visited.add(current_url)
            
            print(f"Обработано: {current_url} | Найдено ссылок: {len(links)}")
            
        except Exception as e:
            print(f"Ошибка при обработке {current_url}: {str(e)}")
            continue
            
    return result

if __name__ == "__main__":
    start_url = input("Введите начальный URL для обхода: ")
    max_pages = int(input("Максимальное количество страниц (по умолчанию 10): ") or 10)
    
    print("\nНачинаем сканирование...\n")
    links_dict = web_crawler(start_url, max_pages)
    
    print("\nРезультаты сканирования:")
    for url, links in links_dict.items():
        print(f"\nСтраница: {url}")
        print(f"Найдено ссылок: {len(links)}")
        if input("Показать ссылки? (y/n): ").lower() == 'y':
            for i, link in enumerate(links[:10], 1):  # Показываем первые 10 ссылок
                print(f"{i}. {link}")
            if len(links) > 10:
                print(f"... и еще {len(links)-10} ссылок")