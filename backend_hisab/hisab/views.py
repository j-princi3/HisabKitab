from rest_framework.views import APIView, View
from hisab.models import Register, Count, Parent_Expense,Child_Expense, ExtraExpense, BankBalance
from hisab.serializers import ShopSerializer, CountSerializer, ExpenseSerializer, ExtraExpenseSerializer
from django.http import HttpResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework import status
from django.core.exceptions import ObjectDoesNotExist

#API for Shop-User Registration
# same members can be added to database multiple times
class ShopRegistration(APIView):
    def post(self, request):
        serializer = ShopSerializer(data=request.data)
        if serializer.is_valid():
            username = serializer.validated_data.get('username')
            password = serializer.validated_data.get('password')
            shop_name = serializer.validated_data.get('shop_name')
            hashed_password = "maha"+password+"veera"
            member=Register(username=username, password=hashed_password, shop_name=shop_name)
            member.save()
            return Response({"message": "Shop Registration Successful", "username": username, "shop_name": shop_name}, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
#API for Shop-User Login
#Authentication check?
class ShopLogin(APIView):
    def get(self, request):
        username = request.query_params.get('username')
        password = request.query_params.get('password')
        hashed_password = "maha"+password+"veera"
        try:
            member = Register.objects.get(username=username, password=hashed_password)
            return Response({"message": "Login Successful", "username": username, "shop_name": member.shop_name}, status=status.HTTP_200_OK)
        except Register.DoesNotExist:
            return Response({"message": "Login Failed"}, status=status.HTTP_400_BAD_REQUEST)
        

# class SearchWithDate(APIView):
#     def get(self,request):
#         date = request.query_params.get('date')
#         try:
#             notesCount = Count.objects.get(time=date)
        
#API for notes count of a day sales (updates bank balance)
class TodayCount(APIView):
    def post(self, request, username):
        serializer = CountSerializer(data=request.data)
        if serializer.is_valid():
            try:
                print(username)
                member = Register.objects.get(username=username)
                print(member.username)
                notes_500 = serializer.validated_data.get('notes_500')
                notes_200 = serializer.validated_data.get('notes_200')
                notes_100 = serializer.validated_data.get('notes_100')
                time = serializer.validated_data.get('time')
                mem_count = Count(shop_name=member.shop_name, notes_500=notes_500, notes_200=notes_200, notes_100=notes_100,time=time)
                mem_count.save()

                last_balance = BankBalance.objects.latest('id')
                notes1_500 = last_balance.notes_500 + notes_500
                notes1_200 = last_balance.notes_200 + notes_200
                notes1_100 = last_balance.notes_100 + notes_100
                mem_bank = BankBalance(shop_name=member.shop_name, notes_500=notes1_500, notes_200=notes1_200, notes_100=notes1_100,total=notes1_500*500+notes1_200*200+notes1_100*100,time=time)
                mem_bank.save()
                return Response({"message": "Count Added Successfully", "shop_name": member.shop_name,"BankBalnce":{"notes_500":notes_500, "notes_200":notes_200, "notes_100":notes_100,"total":notes_500*500+notes_200*200+notes_100*100}}, status=status.HTTP_201_CREATED)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#API for a day expense for accounting purpose
class Expense(APIView):
    def post(self,request,username):
        serializer = ExpenseSerializer(data=request.data)
        if serializer.is_valid():
            try:
                member = Register.objects.get(username=username)
                time = serializer.validated_data.get('time')
                no_of_expense = serializer.validated_data.get('no_of_expense')
                list_of_expense = serializer.validated_data.get('list_of_expense')
                print(list_of_expense)
                parent = Parent_Expense(shop_name=member.shop_name,time=time,no_of_expense=no_of_expense)
                parent.save()
                parent_id = parent.id
                if no_of_expense == len(list_of_expense):
                    for i in range(no_of_expense):
                        child = Child_Expense(parent_id=parent_id,description=list_of_expense[i]['description'],amount=list_of_expense[i]['amount'])
                        child.save()
                    return Response({"message": "Expense Added Successfully", "shop_name": member.shop_name, "no_of_expense": no_of_expense, "list_of_expense": list_of_expense}, status=status.HTTP_201_CREATED)
                else:
                    return Response({"message": "No of expenses and list of expenses not matching"}, status=status.HTTP_400_BAD_REQUEST)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
            
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#API for extra expenses for Bank bag page (updates bank balance)
class ExtraExpenseToday(APIView):
    def post(self, request, username):
        serializer = ExtraExpenseSerializer(data=request.data)
        if serializer.is_valid():
            try:
                mem = Register.objects.get(username=username)
                notes_500 = serializer.validated_data.get('notes_500')
                notes_200 = serializer.validated_data.get('notes_200')
                notes_100 = serializer.validated_data.get('notes_100')
                time = serializer.validated_data.get('time')
                member = ExtraExpense(shop_name=mem.shop_name, notes_500=notes_500, notes_200=notes_200, notes_100=notes_100)
                member.save()
                last_balance = BankBalance.objects.latest('id')
                notes1_500 = last_balance.notes_500 - notes_500
                notes1_200 = last_balance.notes_200 - notes_200
                notes1_100 = last_balance.notes_100 - notes_100
                mem_bank = BankBalance(shop_name=mem.shop_name, notes_500=notes1_500, notes_200=notes1_200, notes_100=notes1_100,total=notes1_500*500+notes1_200*200+notes1_100*100,time=time)
                mem_bank.save()
                return Response({"message": "Extra Expense Added Successfully", "shop_name": member.shop_name, "shop_name": member.shop_name,"BankBalnce":{"notes_500":notes1_500, "notes_200":notes1_200, "notes_100":notes1_100,"total":notes1_500*500+notes1_200*200+notes1_100*100},"Expense":{"notes_500":notes_500, "notes_200":notes_200, "notes_10":notes_100,"total":notes_500*500+notes_200*200+notes_100*100}}, status=status.HTTP_201_CREATED)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class BankBalanceView(APIView):
    def get(self, request, username):
        try:
            member = Register.objects.get(username=username)
            balance = BankBalance.objects.latest('id')
            return Response({"message": "Bank Balance", "shop_name": member.shop_name, "BankBalnce":{"notes_500":balance.notes_500, "notes_200":balance.notes_200, "notes_100":balance.notes_100,"total":balance.total,"time":balance.time}}, status=status.HTTP_200_OK)
        except ObjectDoesNotExist:
            return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)

class HomeView(View):
    def get(self, request):
        return HttpResponse('Welcome to the Home Page!')
