from django.db import models
from apps.RoomType.models import RoomType
from tinymce.models import HTMLField


class Room(models.Model):
    roomNo = models.CharField(max_length=20, default='', primary_key=True, verbose_name='房间号')
    roomTypeObj = models.ForeignKey(RoomType,  db_column='roomTypeObj', on_delete=models.PROTECT, verbose_name='房间类型')
    roomPhoto = models.ImageField(upload_to='img', max_length='100', verbose_name='房间图片')
    roomPrice = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='价格(每天)')
    floorNum = models.CharField(max_length=20, default='', verbose_name='楼层')
    area = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='面积')
    roomDesc = HTMLField(max_length=5000, verbose_name='房间描述')

    class Meta:
        db_table = 't_Room'
        verbose_name = '房间信息'
        verbose_name_plural = verbose_name

    def getJsonObj(self):
        room = {
            'roomNo': self.roomNo,
            'roomTypeObj': self.roomTypeObj.roomTypeName,
            'roomTypeObjPri': self.roomTypeObj.roomTypeId,
            'roomPhoto': self.roomPhoto.url,
            'roomPrice': self.roomPrice,
            'floorNum': self.floorNum,
            'area': self.area,
            'roomDesc': self.roomDesc,
        }
        return room

