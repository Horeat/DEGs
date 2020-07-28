from datetime import datetime

from django.db import models

from app_users.models import UserProfile
from app_methods.models import MethodsInfo

# Create your models here.

class UserHistory(models.Model):
    user_id = models.ForeignKey(UserProfile,verbose_name=u"用户名", on_delete=models.CASCADE)
    upload_file = models.FileField(upload_to="uploads/%Y/%m/%d", verbose_name=u"上传文件", max_length=100)
    method_id = models.CharField(max_length=10,verbose_name=u"方法编号",default="1001")
    args_choose = models.CharField(max_length=50, verbose_name=u"参数选择")
    result_file = models.FileField(upload_to="result/%Y/%m/%d", verbose_name=u"筛选结果文件", max_length=100)
    use_time = models.DateTimeField(default=datetime.now, verbose_name=u"操作时间")

    class Meta:
        verbose_name = "用户历史"
        verbose_name_plural = verbose_name

    # def __str__(self):
    #     return self.user_id


class UserMessage(models.Model):
    user = models.IntegerField(default=0, verbose_name=u"接收用户") # 0是发给全体用户的 ！= 0是就是发个id是几的用户
    message = models.CharField(max_length=500, verbose_name=u"消息内容")
    has_read = models.BooleanField(default=False, verbose_name=u"是否已读")
    add_time = models.DateTimeField(default=datetime.now, verbose_name=u"添加时间")

    class Meta:
        verbose_name = u"用户消息"
        verbose_name_plural = verbose_name
