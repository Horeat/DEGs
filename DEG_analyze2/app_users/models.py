from datetime import datetime

from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.


class UserProfile(AbstractUser):
    nick_name = models.CharField(max_length=50, verbose_name=u"昵称", default="")
    birday = models.DateField(verbose_name=u"生日", null=True, blank=True)
    gender =  models.CharField(max_length=10,choices=(("male","男"),("female","女")), default="female")
    address = models.CharField(max_length=100, default=u"")
    mobile = models.CharField(max_length=11, null=True, blank=True)
    image = models.ImageField(upload_to="image/%Y/%m",default=u"image/default.png",max_length=100)

    class Meta:
        verbose_name = "用户信息"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.username
    
    def unread_nums(self):
    #获取用户未读消息的数量
        from app_operation.models import UserMessage
        return UserMessage.objects.filter(user=self.id, has_read=False).count()



class EmailVerifyRecord(models.Model): 
    code = models.CharField(max_length=20, verbose_name=u"验证码")
    email = models.EmailField(max_length=50, verbose_name=u"邮箱")
    send_type = models.CharField(max_length=30, verbose_name=u"验证码类型", choices=(("register",u"注册"),("forget",u"找回密码"), ("update_email",u"修改邮箱")))
    send_time = models.DateTimeField(verbose_name=u"发送时间", default=datetime.now) # 把now()：取编译的时间 now:取实例化的时间

    class Meta:
        verbose_name = u"邮箱验证码"
        verbose_name_plural = verbose_name

    def __str__(self):
        return '{0}({1})'.format(self.code, self.email)

