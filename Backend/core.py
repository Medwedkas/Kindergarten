import json

config = json.load(open('config.json', 'r'))
web_config = config['web']
db_config = config['db']
token_config = config['token']
