# _*_ encoding:utf-8 _*_
from django.shortcuts import render
from django.views.generic import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from django.http import HttpResponse
from django.db.models import Q
from django.urls import reverse
from django.http import HttpResponseRedirect

from .models import MethodsInfo
# Create your views here.




class MethodListView(View):
    """
    方法列表页
    """
    def get(self, request):
        all_methods = MethodsInfo.objects.all()

        sort = request.GET.get('sort', "")
        if sort:
            if sort == "hot":
                all_methods = all_methods.order_by("-use_number")

        #对讲师进行分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_methods, 3, request=request)

        methods = p.page(page)
        return render(request, "methods-list.html", {
            "all_methods":methods,
            "sort":sort,
        })


class MethodDetailView(View):
    def get(self, request, method_id):
        method = MethodsInfo.objects.get(method_id=int(method_id))
        if method_id == "1001":
            return render(request, "method-1001.html", {
                "method":method,
            })
        if method_id == "1002":
            return render(request, "method-1002.html", {
                "method":method,
            })
        if method_id == "1003":
            return render(request, "method-1003.html", {
                "method":method,
            })
        if method_id == "1004":
            return render(request, "method-1004.html", {
                "method":method,
            })
        if method_id == "1005":
            return render(request, "method-1005.html", {
                "method":method,
            })
        if method_id == "1006":
            return render(request, "method-1006.html", {
                "method":method,
            })
        if method_id == "1007":
            return render(request, "method-1007.html", {
                "method":method,
            })
        if method_id == "2001":
            return render(request, "method-2001.html", {
                "method":method,
            })
        if method_id == "2002":
            return render(request, "method-2002.html", {
                "method":method,
            })
