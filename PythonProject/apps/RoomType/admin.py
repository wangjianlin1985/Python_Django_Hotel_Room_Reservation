from django.contrib import admin
from apps.RoomType.models import RoomType

# Register your models here.

admin.site.register(RoomType,admin.ModelAdmin)