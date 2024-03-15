from django.db import models
from django.contrib.auth.hashers import make_password

class Register(models.Model):
    shop_name = models.CharField(max_length=100)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
