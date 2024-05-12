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
            return Response({"message": "Login Successful"}, status=status.HTTP_200_OK)
        except Register.DoesNotExist:
            return Response({"message": "Login Failed"}, status=status.HTTP_400_BAD_REQUEST)
        


        
#API for notes count of a day sales (updates bank balance)
class TodaysCount(APIView):
    def post(self, request, username):
        serializer = CountSerializer(data=request.data)
        if serializer.is_valid():
            try:
                member = Register.objects.get(username=username)
                notes_500 = serializer.validated_data.get('notes_500')
                notes_200 = serializer.validated_data.get('notes_200')
                notes_100 = serializer.validated_data.get('notes_100')
                total_sales = serializer.validated_data.get('total_sales')
                time = serializer.validated_data.get('time')
                if Count.objects.filter(time=time).exists():
                    return Response({"message": "Count for this day already exists"}, status=status.HTTP_404_NOT_FOUND)
                mem_count = Count(shop_name=member.shop_name, notes_500=notes_500, notes_200=notes_200, notes_100=notes_100,total_sales=total_sales,time=time)
                mem_count.save()
                last_balance = BankBalance.objects.latest('id')
                notes1_500 = last_balance.notes_500 + notes_500
                notes1_200 = last_balance.notes_200 + notes_200
                notes1_100 = last_balance.notes_100 + notes_100
                mem_bank = BankBalance(shop_name=member.shop_name, notes_500=notes1_500, notes_200=notes1_200, notes_100=notes1_100,total=notes1_500*500+notes1_200*200+notes1_100*100,time=time)
                mem_bank.save()
                # return Response({"message": "Count Added Successfully", "shop_name": member.shop_name,"BankBalnce":{"notes_500":notes_500, "notes_200":notes_200, "notes_100":notes_100,"total":notes_500*500+notes_200*200+notes_100*100}}, status=status.HTTP_201_CREATED)
                return Response({"message": "Count has been added successfully and also updated bank balance of the day", "shop_name": member.shop_name},status=status.HTTP_201_CREATED)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#API for a day expense for accounting purpose
class TodaysExpense(APIView):
    def post(self,request,username):
        serializer = ExpenseSerializer(data=request.data)
        if serializer.is_valid():
            try:
                member = Register.objects.get(username=username)
                date = serializer.validated_data.get('time')
                no_of_expense = serializer.validated_data.get('no_of_expense')
                list_of_expense = serializer.validated_data.get('list_of_expense')
                if Parent_Expense.objects.filter(time=date).exists():
                    return Response({"message": "expense for this day already exists"}, status=status.HTTP_404_NOT_FOUND)
                if no_of_expense == 0:
                    return Response({"message": "No expenses to add"}, status=status.HTTP_201_CREATED)
                parent = Parent_Expense(shop_name=member.shop_name,time=date,no_of_expense=no_of_expense)
                parent.save()
                parent_id = parent.id
                if no_of_expense == len(list_of_expense):
                    for i in range(no_of_expense):
                        child = Child_Expense(parent_id=parent_id,description=list_of_expense[i]['description'],amount=list_of_expense[i]['amount'])
                        child.save()
                    return Response({"message": f"Expense Added Successfully to {member.shop_name} on {date}"}, status=status.HTTP_201_CREATED)
                else:
                    return Response({"message": "Expense list did not get added"}, status=status.HTTP_400_BAD_REQUEST)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
            
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        
        
class BankBalanceView(APIView):
    def get(self, request, username):
        try:
            member = Register.objects.get(username=username)
            balance = BankBalance.objects.latest('id')
            return Response({"message": "Bank Balance", "shop_name": member.shop_name, "BankBalnce":[balance.notes_500, balance.notes_200, balance.notes_100,balance.total,balance.time]}, status=status.HTTP_200_OK)
        except ObjectDoesNotExist:
            return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        


#API for extra expenses for Bank bag page (updates bank balance)
class TodaysExtraExpense(APIView):
    def post(self, request, username):
        serializer = ExtraExpenseSerializer(data=request.data)
        if serializer.is_valid():
            try:
                mem = Register.objects.get(username=username)
                notes_500 = serializer.validated_data.get('notes_500')
                notes_200 = serializer.validated_data.get('notes_200')
                notes_100 = serializer.validated_data.get('notes_100')
                description = serializer.validated_data.get('description')
                date = serializer.validated_data.get('time')
                member = ExtraExpense(shop_name=mem.shop_name, notes_500=notes_500, notes_200=notes_200, notes_100=notes_100,description=description,time=date)
                member.save()
                last_balance = BankBalance.objects.latest('id')
                notes1_500 = last_balance.notes_500 - notes_500
                notes1_200 = last_balance.notes_200 - notes_200
                notes1_100 = last_balance.notes_100 - notes_100
                mem_bank = BankBalance(shop_name=mem.shop_name, notes_500=notes1_500, notes_200=notes1_200, notes_100=notes1_100,total=notes1_500*500+notes1_200*200+notes1_100*100,time=date)
                mem_bank.save()
                return Response({"message": "Extra Expense Added Successfully {member.shop_name} on {date}"}, status=status.HTTP_201_CREATED)
            except ObjectDoesNotExist:
                return Response({"message": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



class SearchWithDate(APIView):
    def get(self, request):
        date = request.query_params.get('date')
        
        try:
            notesCount = Count.objects.get(time=date)
            balanceOnThatDay = BankBalance.objects.filter(time=date)  # Changed to filter
        except ObjectDoesNotExist:
            return Response({"message": f"Hisab was not found on this date {date}"}, status=status.HTTP_404_NOT_FOUND)
        
        try:
            parent = Parent_Expense.objects.get(time=date)
            child = Child_Expense.objects.filter(parent_id=parent.id)
            expenseList = [{ i.description : i.amount} for i in child]
        except Parent_Expense.DoesNotExist:
            expenseList = []  # Empty list if parent does not exist
        
        extraExpense = ExtraExpense.objects.filter(time=date)
        extraExpenseList = [{"500 ": i.notes_500, "200 ": i.notes_200, "100 ": i.notes_100} for i in extraExpense]

        # Collect all balance data if there are multiple objects
        balance_data_list = []
        for balance_obj in balanceOnThatDay:
            balance_data_list.append({
                "500 ": balance_obj.notes_500,
                "200 ": balance_obj.notes_200,
                "100 ": balance_obj.notes_100,
                "total ": balance_obj.total
            })

            return Response({
    "date": date,
    "total_sales": notesCount.total_sales,
    "notes_500": notesCount.notes_500,
    "notes_200": notesCount.notes_200,
    "notes_100": notesCount.notes_100,
    "balance_data_list": balance_data_list,
    "expenseList": expenseList,
    "extraExpenseList": extraExpenseList
}, status=status.HTTP_200_OK)

class HomeView(View):
    def get(self, request):
        return HttpResponse('Welcome to the Home Page!')
