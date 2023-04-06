import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import re

def getDemandProducts(product_name):
    data_list = get_product(product_name)
    print(data_list)
    print("-----------------------------------------------------------------------------------------------")
    trending_products = sorted(data_list, key=lambda x: x['total_sold'], reverse=True)[:3]
    return trending_products
    
    

def get_product(product_name):
    data_list = []
    url = 'https://www.ebay.com/sch/i.html?_nkw=' + product_name

    number_of_pages = 1
    page_number = 1

    while page_number <= number_of_pages:
        page_number +=1
        page = url + "&_pgn=" + str(page_number)
        response = requests.get(page)

        if response.ok:
            products = get_index_data(get_page(page))
            pbar = tqdm(total = len(products))

            for link in products:
                soup = get_page(link)
                pbar.update(1)

                if soup != '':
                    print(link)
                    data = get_detail_data(soup, link)
                    if product_name.lower() in (data["title"]).lower():
                      data_list.append(data)
                else:
                    print("Page Error")
            pbar.close
        else:
           break
    return data_list
            
        

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
  


def get_index_data(soup):
  try:
    links = soup.find_all('a',{'class':'s-item__link'})
  except:
    links = []

  urls = [item.get('href') for item in links]

  return urls



def get_detail_data(soup, link):
  items_sold = ''
  #Title
  try:
    title = soup.find('h1',{'class': 'x-item-title__mainTitle'}).find('span',{'class':'ux-textspans ux-textspans--BOLD'}).text
  except:
    title = ''

  #Price
  try:
    price = soup.find('span', itemprop = 'price') .find('span',{'class':'ux-textspans'}).text
  except: 
    price = ''

  # Total items sold
  try:
    items_sold = soup.find('div',{'class':'d-quantity__availability'}).text.split("/")
  except:
    iems_sold = ''
  
  numeric_value = 0

  if items_sold != '':
    if len(items_sold) > 1:
      items_sold = items_sold[1].strip()
      digits = re.findall(r'\d+', items_sold)
      numeric_value = int(''.join(digits))

      if numeric_value == None:
        numeric_value = 0
      print(numeric_value)

  data = {
      'title': title,
      'price': price,
      'total_sold':numeric_value,
      'product_url': link
  }

  return(data)