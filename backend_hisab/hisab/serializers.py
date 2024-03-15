from rest_framework import serializers
from hisab.models import Register

class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Register
        fields = '__all__'

    def create(self, validated_data):
        return super().create(validated_data)


