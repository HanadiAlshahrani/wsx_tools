import requests

payload = {"table":"users", "value":'(3, "Mike", 99)'}

response = requests.post('http://127.0.0.1:5000/create_entry', json=payload)
print(response.content)
