from django.db import models

class Register(models.Model):
    shop_name = models.CharField(max_length=100)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)


class Count(models.Model):
    shop_name = models.CharField(max_length=100)
    notes_500 = models.IntegerField(default=0)
    notes_200 = models.IntegerField(default=0)
    notes_100 = models.IntegerField(default=0)
    time=models.DateTimeField()

class Parent_Expense(models.Model):
    shop_name = models.CharField(max_length=100)
    time=models.DateTimeField()
    no_of_expense=models.IntegerField()

class Child_Expense(models.Model):
    parent_id=models.IntegerField()
    description=models.CharField(max_length=100)
    amount=models.IntegerField()

class ExtraExpense(models.Model):
    shop_name = models.CharField(max_length=100)
    notes_500 = models.IntegerField(default=0)
    notes_200 = models.IntegerField(default=0)
    notes_100 = models.IntegerField(default=0)
    time=models.DateTimeField()

class BankBalance(models.Model):
    shop_name = models.CharField(max_length=100)
    notes_500 = models.IntegerField()
    notes_200 = models.IntegerField()
    notes_100 = models.IntegerField()
    total = models.IntegerField()
    time=models.DateTimeField()