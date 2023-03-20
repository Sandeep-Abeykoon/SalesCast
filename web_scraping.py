import csv
import requests
from bs4 import BeautifulSoup
from tqdm import tqdm

def get_page(url):
  response = requests.get(url)
  #print(response.ok)
  #print(response.status_code)

  if not response.ok:
    #print("Server responded: ", response.status_code)
    #print("Page Error")
    return ''
  else:
    soup = BeautifulSoup(response.text, 'html.parser')
    return soup
  

  
def get_detail_data(soup):
    tems_sold = ''
    #Title
    try:
        title = soup.find('h1',{'class': 'x-item-title__mainTitle'}).find('span',{'class':'ux-textspans ux-textspans--BOLD'}).text
    except:
        title = ''
        print(title)

    #Price
    try:
        price = soup.find('span', itemprop = 'price') .find('span',{'class':'ux-textspans'}).text
    except: 
        price = ''
    print(price)

    # Total items sold
    try:
        items_sold = soup.find('div',{'class':'d-quantity__availability'}).text.split("/")
    except:
        iems_sold = ''

    if items_sold != '':
        if len(items_sold) > 1:
            items_sold = items_sold[1].strip()

    data = {
      'title': title,
      'price': price,
      'total_sold':items_sold
    }

    print(data)
    return(data)



def get_index_data(soup):
  try:
    links = soup.find_all('a',{'class':'s-item__link'})
  except:
    links = []

  urls = [item.get('href') for item in links]

  return urls


def write_csv(data, url):
  with open('output.csv', 'a') as csvfile:
    writer = csv.writer(csvfile)

    row = [data['title'], data['price'], data['total_sold'], url]
    writer.writerow(row)



    from requests.models import Response
def main():
  url = 'https://www.ebay.com/sch/i.html?_nkw=nutella'
  page_number = 0

  while True:
    page_number +=1
    page = url + "&_pgn=" + str(page_number)
    response = requests.get(page)

    if response.ok:
      products = get_index_data(get_page(page))
      pbar = tqdm(total=len(products))

      for link in products:
        soup = get_page(link)
        pbar.update(1)

        if soup != '':
          print(link)
          data = get_detail_data(soup)
          write_csv(data, link)
        else:
          print("Page Error")
      pbar.close()
    else:
      break
    

