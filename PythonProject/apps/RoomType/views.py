from django.views.generic import View
from apps.BaseView import BaseView
from django.shortcuts import render
from django.core.paginator import Paginator
from apps.RoomType.models import RoomType
from django.http import JsonResponse
from django.http import FileResponse
from apps.BaseView import ImageFormatException
from django.conf import settings
import pandas as pd
import os


class FrontAddView(BaseView):  # 前台房间类型添加
    def get(self,request):

        # 使用模板
        return render(request, 'RoomType/roomType_frontAdd.html')

    def post(self, request):
        roomType = RoomType() # 新建一个房间类型对象然后获取参数
        roomType.roomTypeName = request.POST.get('roomType.roomTypeName')
        roomType.roomTypeDesc = request.POST.get('roomType.roomTypeDesc')
        roomType.save() # 保存房间类型信息到数据库
        return JsonResponse({'success': True, 'message': '保存成功'})


class FrontModifyView(BaseView):  # 前台修改房间类型
    def get(self, request, roomTypeId):
        context = {'roomTypeId': roomTypeId}
        return render(request, 'RoomType/roomType_frontModify.html', context)


class FrontListView(BaseView):  # 前台房间类型查询列表
    def get(self, request):
        return self.handle(request)

    def post(self, request):
        return self.handle(request)

    def handle(self, request):
        self.getCurrentPage(request)  # 获取当前要显示第几页
        # 下面获取查询参数
        # 然后条件组合查询过滤
        roomTypes = RoomType.objects.all()
        # 对查询结果利用Paginator进行分页
        self.paginator = Paginator(roomTypes, self.pageSize)
        # 计算总的页码数，要显示的页码列表，总记录等
        self.calculatePages()
        # 获取第page页的Page实例对象
        roomTypes_page = self.paginator.page(self.currentPage)

        # 构造模板需要的参数
        context = {
            'roomTypes_page': roomTypes_page,
            'currentPage': self.currentPage,
            'totalPage': self.totalPage,
            'recordNumber': self.recordNumber,
            'startIndex': self.startIndex,
            'pageList': self.pageList,
        }
        # 渲染模板界面
        return render(request, 'RoomType/roomType_frontquery_result.html', context)


class FrontShowView(View):  # 前台显示房间类型详情页
    def get(self, request, roomTypeId):
        # 查询需要显示的房间类型对象
        roomType = RoomType.objects.get(roomTypeId=roomTypeId)
        context = {
            'roomType': roomType
        }
        # 渲染模板显示
        return render(request, 'RoomType/roomType_frontshow.html', context)


class ListAllView(View): # 前台查询所有房间类型
    def get(self,request):
        roomTypes = RoomType.objects.all()
        roomTypeList = []
        for roomType in roomTypes:
            roomTypeObj = {
                'roomTypeId': roomType.roomTypeId,
                'roomTypeName': roomType.roomTypeName,
            }
            roomTypeList.append(roomTypeObj)
        return JsonResponse(roomTypeList, safe=False)


class UpdateView(BaseView):  # Ajax方式房间类型更新
    def get(self, request, roomTypeId):
        # GET方式请求查询房间类型对象并返回房间类型json格式
        roomType = RoomType.objects.get(roomTypeId=roomTypeId)
        return JsonResponse(roomType.getJsonObj())

    def post(self, request, roomTypeId):
        # POST方式提交房间类型修改信息更新到数据库
        roomType = RoomType.objects.get(roomTypeId=roomTypeId)
        roomType.roomTypeName = request.POST.get('roomType.roomTypeName')
        roomType.roomTypeDesc = request.POST.get('roomType.roomTypeDesc')
        roomType.save()
        return JsonResponse({'success': True, 'message': '保存成功'})

class AddView(BaseView):  # 后台房间类型添加
    def get(self,request):

        # 渲染显示模板界面
        return render(request, 'RoomType/roomType_add.html')

    def post(self, request):
        # POST方式处理图书添加业务
        roomType = RoomType() # 新建一个房间类型对象然后获取参数
        roomType.roomTypeName = request.POST.get('roomType.roomTypeName')
        roomType.roomTypeDesc = request.POST.get('roomType.roomTypeDesc')
        roomType.save() # 保存房间类型信息到数据库
        return JsonResponse({'success': True, 'message': '保存成功'})


class BackModifyView(BaseView):  # 后台更新房间类型
    def get(self, request, roomTypeId):
        context = {'roomTypeId': roomTypeId}
        return render(request, 'RoomType/roomType_modify.html', context)


class ListView(BaseView):  # 后台房间类型列表
    def get(self, request):
        # 使用模板
        return render(request, 'RoomType/roomType_query_result.html')

    def post(self, request):
        # 获取当前要显示第几页和每页几条数据
        self.getPageAndSize(request)
        # 收集查询参数
        # 然后条件组合查询过滤
        roomTypes = RoomType.objects.all()
        # 利用Paginator对查询结果集分页
        self.paginator = Paginator(roomTypes, self.pageSize)
        # 计算总的页码数，要显示的页码列表，总记录等
        self.calculatePages()
        # 获取第page页的Page实例对象
        roomTypes_page = self.paginator.page(self.currentPage)
        # 查询的结果集转换为列表
        roomTypeList = []
        for roomType in roomTypes_page:
            roomType = roomType.getJsonObj()
            roomTypeList.append(roomType)
        # 构造模板页面需要的参数
        roomType_res = {
            'rows': roomTypeList,
            'total': self.recordNumber,
        }
        # 渲染模板页面显示
        return JsonResponse(roomType_res, json_dumps_params={'ensure_ascii':False})

class DeletesView(BaseView):  # 删除房间类型信息
    def get(self, request):
        return self.handle(request)

    def post(self, request):
        return self.handle(request)

    def handle(self, request):
        roomTypeIds = self.getStrParam(request, 'roomTypeIds')
        roomTypeIds = roomTypeIds.split(',')
        count = 0
        try:
            for roomTypeId in roomTypeIds:
                RoomType.objects.get(roomTypeId=roomTypeId).delete()
                count = count + 1
            message = '%s条记录删除成功！' % count
            success = True
        except Exception as e:
            message = '数据库外键约束删除失败！'
            success = False
        return JsonResponse({'success': success, 'message': message})


class OutToExcelView(BaseView):  # 导出房间类型信息到excel并下载
    def get(self, request):
        # 收集查询参数
        # 然后条件组合查询过滤
        roomTypes = RoomType.objects.all()
        #将查询结果集转换成列表
        roomTypeList = []
        for roomType in roomTypes:
            roomType = roomType.getJsonObj()
            roomTypeList.append(roomType)
        # 利用pandas实现数据的导出功能
        pf = pd.DataFrame(roomTypeList)
        # 设置要导入到excel的列
        columns_map = {
            'roomTypeId': '类型id',
            'roomTypeName': '房间类型',
        }
        pf = pf[columns_map.keys()]
        pf.rename(columns=columns_map, inplace=True)
        # 将空的单元格替换为空字符
        pf.fillna('', inplace=True)
        #设定文件名和导出路径
        filename = 'roomTypes.xlsx'
        # 这个路径可以在settings中设置也可以直接手动输入
        root_path = settings.MEDIA_ROOT + '/output/'
        file_path = os.path.join(root_path, filename)
        pf.to_excel(file_path, encoding='utf-8', index=False)
        # 将生成的excel文件输出到网页下载
        file = open(file_path, 'rb')
        response = FileResponse(file)
        response['Content-Type'] = 'application/octet-stream'
        response['Content-Disposition'] = 'attachment;filename="roomTypes.xlsx"'
        return response

