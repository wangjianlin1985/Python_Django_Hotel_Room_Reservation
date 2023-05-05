from django.db import models
from apps.Room.models import Room
from apps.UserInfo.models import UserInfo


class BookOrder(models.Model):
    orderId = models.AutoField(primary_key=True, verbose_name='订单id')
    roomObj = models.ForeignKey(Room,  db_column='roomObj', on_delete=models.PROTECT, verbose_name='预订房间')
    liveDate = models.CharField(max_length=20, default='', verbose_name='入住日期')
    leaveDate = models.CharField(max_length=20, default='', verbose_name='离开日期')
    totalMoney = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='订单总价')
    orderState = models.CharField(max_length=20, default='', verbose_name='订单状态')
    orderMemo = models.CharField(max_length=500, default='', verbose_name='订单备注')
    userObj = models.ForeignKey(UserInfo,  db_column='userObj', on_delete=models.PROTECT, verbose_name='预订人')
    telephone = models.CharField(max_length=20, default='', verbose_name='联系电话')
    orderTime = models.CharField(max_length=20, default='', verbose_name='预订时间')

    class Meta:
        db_table = 't_BookOrder'
        verbose_name = '房间预订信息'
        verbose_name_plural = verbose_name

    def getJsonObj(self):
        bookOrder = {
            'orderId': self.orderId,
            'roomObj': self.roomObj.roomNo,
            'roomObjPri': self.roomObj.roomNo,
            'liveDate': self.liveDate,
            'leaveDate': self.leaveDate,
            'totalMoney': self.totalMoney,
            'orderState': self.orderState,
            'orderMemo': self.orderMemo,
            'userObj': self.userObj.name,
            'userObjPri': self.userObj.user_name,
            'telephone': self.telephone,
            'orderTime': self.orderTime,
        }
        return bookOrder

