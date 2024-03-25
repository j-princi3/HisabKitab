from rest_framework import serializers
from hisab.models import Register, Count, Expense, ExtraExpense, BankBalance

class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Register  # Set the model to be serialized
        fields = '__all__'  # Include all fields from the model

class CountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Count  # Set the model to be serialized
        fields = ["notes_500","notes_200","notes_100","time"]  # Include all fields from the model

class ExpenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Expense  # Set the model to be serialized
        fields = '__all__'  # Include all fields from the model

class ExtraExpenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExtraExpense  # Set the model to be serialized
        fields = ["notes_500","notes_200","notes_100","time"] # Include all fields from the model

class BankBalanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = BankBalance  # Set the model to be serialized
        fields = '__all__'  # Include all fields from the model