# -*- coding: utf-8 -*-

from django.conf.urls import url, include
from .views import UploadView, CheckArgsView, RNAResultsView1, RNAResultsView0, ProbResultsView, DiyVolcanoView, DiyHeatView


urlpatterns = [
    # 上传文件
    url(r'^uploadfile/$', UploadView.as_view(), name="uploadfile"),

    # 检查参数计算结果
    url(r'^check/$', CheckArgsView.as_view(), name="check_args"),

    # RNA数据结果展示1
    url(r'^result_RNA1/$', RNAResultsView1.as_view(), name="result_RNA1"),

    # RNA数据结果展示0
    url(r'^result_RNA0/$', RNAResultsView0.as_view(), name="result_RNA0"),

    # Prob数据结果展示
    url(r'^result_Prob/$', ProbResultsView.as_view(), name="result_Prob"),

    #用户自定义画火山图
    url(r'^DIY_volcano/$', DiyVolcanoView.as_view(), name="DIY_volcano"),
    
    #用户自定义画热图
    url(r'^DIY_heat/$', DiyHeatView.as_view(), name="DIY_heat"),

]