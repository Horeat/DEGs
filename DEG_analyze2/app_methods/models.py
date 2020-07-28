from django.db import models

# Create your models here.


class MethodsInfo(models.Model):
    method_id = models.IntegerField(verbose_name=u"方法编号", primary_key=True, default=1000)
    method_name = models.CharField(max_length=50, verbose_name=u"方法名称")
    method_type =  models.CharField(verbose_name=u"方法类型", max_length=20, choices=(("With Select Tag","有筛选指标"),("No Select Tag","无筛选指标")), default="With Select Tag")
    method_detail = models.TextField(verbose_name=u"方法详情")
    author = models.CharField(max_length=20, verbose_name=u"作者名称", null=True, blank=True, default=u"")
    args = models.CharField(max_length=80, verbose_name=u"常用参数", null=True, blank=True)
    use_number = models.IntegerField(default=0, verbose_name=u"使用次数")

    class Meta:
        verbose_name = "筛选方法"
        verbose_name_plural = verbose_name

    def __str__(self):
        return str(self.method_id)