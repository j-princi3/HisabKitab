"""
URL configuration for backend_hisab project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.urls import path
from hisab.views import HomeView,ShopRegistration,ShopLogin,TodaysCount,TodaysExpense,TodaysExtraExpense,BankBalanceView,SearchWithDate
from django.contrib import admin

urlpatterns = [
    path('', HomeView.as_view(), name='home'), 
    # Handles user registration.
    path('register/', ShopRegistration.as_view(), name='Register'), 
    # Handles user login.  
    path('login/', ShopLogin.as_view(), name='Login'),
    # Counts the number of transactions for the day.
    path('count/<str:username>', TodaysCount.as_view(), name='Count'),
    # Retrieves today's expenses for a user.
    path('expense/<str:username>', TodaysExpense.as_view(), name='Expense'),
    # Adds extra expenses for the day and updates the bank balance.
    path('extraexpense/<str:username>', TodaysExtraExpense.as_view(), name='ExtraExpense'),
    # Retrieves the bank balance for a user.
    path('getbankbalance/<str:username>', BankBalanceView.as_view(), name='BankBalanceView'),
    # Retrieves the transactions for a specific date.
    path('date/', SearchWithDate.as_view(),name='Date'),


    path('admin/', admin.site.urls),
]

