from django.contrib import admin
from apps.BookOrder.models import BookOrder

# Register your models here.

admin.site.register(BookOrder,admin.ModelAdmin)