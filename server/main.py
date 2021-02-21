#!/usr/bin/env python3

from flask import Flask
from flask_restful import Resource, Api, reqparse
import datetime
import random


class Stat:
    def __init__(self, name, description):
        self.timestamp = datetime.datetime.now().timestamp()
        self.name = name
        self.greenCount = random.randint(0, 100000)
        self.yellowCount = random.randint(0, 50)
        self.redCount = random.randint(0, 40)
        self.description = description
        self.stat = {'timestamp': self.timestamp,
                     'type': self.name,
                     'greenCount': self.greenCount,
                     'yellowCount': self.yellowCount,
                     'redCount': self.redCount,
                     'description': self.description}


class Stats(Resource):
    def get(self):
        stats = {"stats": [Stat('Backbone', 'Number of backbone links').stat,
                           Stat('Devices', 'Number of devices').stat,
                           Stat('Services', 'Number of services').stat]}
        print(stats)
        return stats, 200


app = Flask(__name__)
api = Api(app)
api.add_resource(Stats, '/stats')

if __name__ == '__main__':
    app.run(host='0.0.0.0')
