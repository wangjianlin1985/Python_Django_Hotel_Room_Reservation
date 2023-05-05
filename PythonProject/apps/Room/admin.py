from django.contrib import admin
from apps.Room.models import Room

# Register your models here.

admin.site.register(Room,admin.ModelAdmin)