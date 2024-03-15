from rest_framework.views import APIView, View
from hisab.models import Register
from hisab.serializers import ShopSerializer
from django.http import HttpResponse
from django.contrib.auth.hashers import make_password

class ShopRegistration(APIView):
    def get(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        shop_name = request.data.get('shop_name')

        # Check if any field is not provided
        if not username or not password or not shop_name:
            return HttpResponse('Missing fields', status=400)

        # Check if a Register instance with the given username already exists
        register = Register.objects.filter(username=username).first()
        if register and register.shop_name == shop_name:
            return HttpResponse('Username already exists', status=400)

        password = "maha"+password+"veera"
        register = Register(username=username, password=password, shop_name=shop_name)
        register.save()

        return HttpResponse('Shop Registered Successfully!')

class ShopLogin(APIView):
    def get(self, request):
        username = request.data.get('username')
        password = request.data.get('password')

        # Check if any field is not provided
        if not username or not password:
            return HttpResponse('Missing fields', status=400)

        # Check if a Register instance with the given username already exists
        register = Register.objects.filter(username=username).first()
        if not register:
            return HttpResponse('Username does not exist', status=400)

        password = "maha"+password+"veera"
        if register.password != password:
            return HttpResponse('Invalid Password', status=400)

        return HttpResponse('Login Successful!')


class HomeView(View):
    def get(self, request):
        return HttpResponse('Welcome to the Home Page!')


