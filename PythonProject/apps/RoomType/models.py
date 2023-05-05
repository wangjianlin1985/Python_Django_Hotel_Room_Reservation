from django.db import models
from tinymce.models import HTMLField


class RoomType(models.Model):
    roomTypeId = models.AutoField(primary_key=True, verbose_name='类型id')
    roomTypeName = models.CharField(max_length=20, default='', verbose_name='房间类型')
    roomTypeDesc = HTMLField(max_length=8000, verbose_name='类型介绍')

    class Meta:
        db_table = 't_RoomType'
        verbose_name = '房间类型信息'
        verbose_name_plural = verbose_name

    def getJsonObj(self):
        roomType = {
            'roomTypeId': self.roomTypeId,
            'roomTypeName': self.roomTypeName,
            'roomTypeDesc': self.roomTypeDesc,
        }
        return roomType

