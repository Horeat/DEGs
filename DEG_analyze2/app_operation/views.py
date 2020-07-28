from django.shortcuts import render
from django.urls import reverse
from django.http import HttpResponseRedirect, HttpResponse
from django.views.generic.base import View
from scipy import stats
import os
import math
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.colors as colors 

from DEG_analyze2.settings import BASE_DIR
from app_methods.models import MethodsInfo
from .models import UserHistory


class UploadView(View):
    """
    上传文件并检查内部外部格式
    """
    def post(self, request):
        global file_in
        global c
        method_type = request.POST.get('method_type')
        method_id = request.POST.get('method_id')
        print(method_type)
        print(method_id)
        file_obj = request.FILES.get('file')
        file_name = file_obj.name
        print('>>>>',file_name)
        # 拼接绝对路径
        file_path = os.path.join(BASE_DIR, 'upload_files', file_name)
        #检查文件内部格式，合格的存储，不合格的拒绝
        file_in = pd.read_csv(file_obj)
        c = file_in.columns.values.tolist()
        print(file_in)
        print(c)
        if method_type == "For RNAseq data":
            if method_id == "1001" or method_id == "1003" or method_id == "1005":
                if ("p_value" in c) and (file_in['p_value'].dtype == "float64" or file_in['p_value'].dtype == "int64"):
                    with open(file_path, 'wb')as f:
                        for chunk in file_obj.chunks():#chunks()每次读取数据默认我64k
                            f.write(chunk)  
                    if request.user.is_authenticated:
                        user_hist = UserHistory()
                        user_hist.user_id = request.user
                        user_hist.upload_file = file_obj
                        user_hist.method_id = method_id
                        user_hist.save()
                    file_in.to_csv('./static/result/file_in.csv',index = False)
                    return HttpResponse('{"status":"success","msg":"上传成功!"}', content_type='application/json')
                else:
                    return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保所需字段的命名合格!"}', content_type='application/json')
            if method_id == "1002":
                if ("logFC" in c) and (file_in['logFC'].dtype == "float64" or file_in['logFC'].dtype == "int64"):
                    with open(file_path, 'wb')as f:
                        for chunk in file_obj.chunks():
                            f.write(chunk) 
                    if request.user.is_authenticated:
                        user_hist = UserHistory()
                        user_hist.user_id = request.user
                        user_hist.upload_file = file_obj
                        user_hist.method_id = method_id
                        user_hist.save()
                    file_in.to_csv('./static/result/file_in.csv',index = False)
                    return HttpResponse('{"status":"success","msg":"上传成功!"}', content_type='application/json')
                else:
                    return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保所需字段的命名合格!"}', content_type='application/json')
            if method_id == "1004" or method_id == "1006" or method_id == "1007":
                if ("p_value" in c) and ("logFC" in c) and (file_in['p_value'].dtype == "float64" or file_in['p_value'].dtype == "int64") and (file_in['logFC'].dtype == "float64" or file_in['logFC'].dtype == "int64"):
                    with open(file_path, 'wb')as f:
                        for chunk in file_obj.chunks():
                            f.write(chunk)
                    if request.user.is_authenticated:
                        user_hist = UserHistory()
                        user_hist.user_id = request.user
                        user_hist.upload_file = file_obj
                        user_hist.method_id = method_id
                        user_hist.save()
                    file_in.to_csv('./static/result/file_in.csv',index = False)
                    return HttpResponse('{"status":"success","msg":"上传成功!"}', content_type='application/json')  
                else:
                    return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保所需字段的命名合格!"}', content_type='application/json')
        else:
            if len(c)%2 == 0:
                return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保各字段的命名和顺序合格!"}', content_type='application/json')
            else:
                flag = 1
                # check = c[1:len(c)]
                # #检查每列的数据类型
                # for e in check:
                #     if file_in[e].dtype == "float64" or file_in[e].dtype == "int64":
                #         pass
                #     else:
                #         flag = 0
                # #数据类型不符直接返回错误，数据类型相符检查每个数据
                # if flag == 0:
                #     return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保各字段的命名和顺序合格，且确保表达值为数值类型!"}', content_type='application/json')
                # else:
                #     for i in range(file_in.shape[0]):       
                #         for j in range(file_in.shape[1]-1):
                #             if float(file_in.iloc[i][j+1]) < 0:
                #                 flag = 0
                if flag == 1:
                    if request.user.is_authenticated:
                        user_hist = UserHistory()
                        user_hist.user_id = request.user
                        user_hist.upload_file = file_obj
                        user_hist.method_id = method_id
                        user_hist.save()
                    file_in.to_csv('./static/result/file_in.csv',index = False)
                    return HttpResponse('{"status":"success","msg":"上传成功!"}', content_type='application/json')
                else:
                    return HttpResponse('{"status":"fail","msg":"文件内部格式出错，请严格按照图片所示和方法描述确保各字段的命名和顺序合格，且确保表达值为数值类型!"}', content_type='application/json')





class CheckArgsView(View):
    """
    获取参数、检查参数的合法性、计算结果
    """
    def post(self, request):
        global filtered_data
        global after_test
        method_type = request.POST.get('method_type')
        method_id = request.POST.get('method_id')
        print(method_type)
        print(method_id)
        #添加使用次数
        method = MethodsInfo.objects.get(method_id=int(method_id))
        method.use_number = method.use_number + 1
        method.save()
        #得到筛选文件
        if method_id == '1001':
            p_value = request.POST.get('p_value')
            print(p_value)
            filtered_data = file_in[file_in['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"p_value<{p_value}"
                    someone_use_now.save()
                    break;
        if method_id == '1002':
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(logFC_big)
            print(logFC_small)
            filtered_data1 = file_in[file_in['logFC'] < float(logFC_small)]
            filtered_data2 = file_in[file_in['logFC'] > float(logFC_big)]
            filtered_data = filtered_data1.append(filtered_data2)
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big}"
                    someone_use_now.save()
                    break;
        if method_id == '1003':
            FDR = request.POST.get('FDR')
            print(FDR)
            if "FDR" in c:
                filtered_data = file_in[file_in['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_in)
                filtered_data = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
                print(file_in_fdr)
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"FDR<{FDR}"
                    someone_use_now.save()
                    break;
        if method_id == '1004':
            p_value = request.POST.get('p_value')
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(p_value)
            print(logFC_big)
            print(logFC_small)
            filtered_data1 = file_in[file_in['logFC'] < float(logFC_small)]
            filtered_data2 = file_in[file_in['logFC'] > float(logFC_big)]
            filtered_data12 = filtered_data1.append(filtered_data2)
            filtered_data = filtered_data12[filtered_data12['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big} p_value<{p_value}"
                    someone_use_now.save()
                    break;
        if method_id == '1005':
            p_value = request.POST.get('p_value')
            FDR = request.POST.get('FDR')
            print(p_value)
            print(FDR)
            if "FDR" in c:
                filtered_data1 = file_in[file_in['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_in)
                filtered_data1 = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
            filtered_data = filtered_data1[filtered_data1['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"p_value<{p_value} FDR<{FDR}"
                    someone_use_now.save()
                    break;
        if method_id == '1006':
            FDR = request.POST.get('FDR')
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(FDR)
            print(logFC_big)
            print(logFC_small)
            if "FDR" in c:
                filtered_data_1 = file_in[file_in['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_in)
                filtered_data_1 = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
            filtered_data1 = filtered_data_1[filtered_data_1['logFC'] < float(logFC_small)]
            filtered_data2 = filtered_data_1[filtered_data_1['logFC'] > float(logFC_big)]
            filtered_data = filtered_data1.append(filtered_data2)
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big} FDR<{FDR}"
                    someone_use_now.save()
                    break;
        if method_id == '1007':
            p_value = request.POST.get('p_value')
            FDR = request.POST.get('FDR')
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(p_value)
            print(FDR)
            print(logFC_big)
            print(logFC_small)
            if "FDR" in c:
                filtered_data_1 = file_in[file_in['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_in)
                filtered_data_1 = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
            filtered_data1 = filtered_data_1[filtered_data_1['logFC'] < float(logFC_small)]
            filtered_data2 = filtered_data_1[filtered_data_1['logFC'] > float(logFC_big)]
            filtered_data12 = filtered_data1.append(filtered_data2)
            filtered_data = filtered_data12[filtered_data12['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big} FDR<{FDR} p_value<{p_value}"
                    someone_use_now.save()
                    break;
        if method_id == '2001':
            processed_file = probdata_preprocess(file_in,10)
            print(processed_file)
            if_log2 = request.POST.get('if_log2')
            print(if_log2)
            file_ttest = t_test_2001(processed_file,if_log2)
            after_test = file_ttest
            after_test.to_csv('./static/result/after_test.csv',index = False)
            print(file_ttest)
            p_value = request.POST.get('p_value')
            FDR = request.POST.get('FDR')
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(p_value)
            print(FDR)
            print(logFC_big)
            print(logFC_small)
            if "FDR" in file_ttest.columns.values.tolist():
                filtered_data_1 = file_ttest[file_ttest['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_ttest)
                filtered_data_1 = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
            filtered_data1 = filtered_data_1[filtered_data_1['logFC'] < float(logFC_small)]
            filtered_data2 = filtered_data_1[filtered_data_1['logFC'] > float(logFC_big)]
            filtered_data12 = filtered_data1.append(filtered_data2)
            filtered_data = filtered_data12[filtered_data12['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big} FDR<{FDR} p_value<{p_value}"
                    someone_use_now.save()
                    break;
        if method_id == '2002':
            processed_file = probdata_preprocess(file_in,1)
            print(file_in)
            if_log2 = request.POST.get('if_log2')
            print(if_log2)
            file_kstest = ks_test_2002(processed_file,if_log2)
            after_test = file_kstest
            after_test.to_csv('./static/result/after_test.csv',index = False)
            print(file_kstest)
            p_value = request.POST.get('p_value')
            FDR = request.POST.get('FDR')
            logFC_big = request.POST.get('logFC_big')
            logFC_small = request.POST.get('logFC_small')
            print(p_value)
            print(FDR)
            print(logFC_big)
            print(logFC_small)
            if "FDR" in file_kstest.columns.values.tolist():
                filtered_data_1 = file_kstest[file_kstest['FDR'] < float(FDR)]
            else:
                file_in_fdr = cal_FDR(file_kstest)
                filtered_data_1 = file_in_fdr[file_in_fdr['FDR'] < float(FDR)]
            filtered_data1 = filtered_data_1[filtered_data_1['logFC'] < float(logFC_small)]
            filtered_data2 = filtered_data_1[filtered_data_1['logFC'] > float(logFC_big)]
            filtered_data12 = filtered_data1.append(filtered_data2)
            filtered_data = filtered_data12[filtered_data12['p_value'] < float(p_value)]
            print(filtered_data)
            filtered_data.to_csv('./static/result/filtered_data.csv',index = False)
            if request.user.is_authenticated:
                someone_use_this = UserHistory.objects.filter(user_id=request.user,method_id=method_id)
                someone_use_this = someone_use_this.order_by("-use_time")
                for someone_use_now in someone_use_this:
                    someone_use_now.args_choose = f"logFC<{logFC_small}&logFC>{logFC_big} FDR<{FDR} p_value<{p_value}"
                    someone_use_now.save()
                    break;

        
        #画图操作
        if method_type == "For RNAseq data":
            if ("p_value" in filtered_data.columns.values.tolist()) and ("logFC" in filtered_data.columns.values.tolist()):
                draw_volcano_map(file_in,filtered_data,"o","#377EB8","grey","#E41A1C")
                print(file_in)
                print(filtered_data)
                return HttpResponse('{"status":"success","msg":"111"}', content_type='application/json')
            else:
                return HttpResponse('{"status":"success","msg":"000"}', content_type='application/json')
        else:
            draw_distribution_map()
            draw_volcano_map(after_test,filtered_data,"o","#377EB8","grey","#E41A1C")
            print(filtered_data)
            print(after_test)
            draw_heat_map("RdYlGn_r",True,True)
            print(filtered_data)
            return HttpResponse('{"status":"success","msg":"222"}', content_type='application/json')
            print(filtered_data)
            
        



class RNAResultsView1(View):
    """
    有火山图和文件的结果页
    """
    def get(self, request):
        the_file_path = "/static/result/filtered_data.csv"
        filtered_file = pd.read_csv('./static/result/filtered_data.csv')
        rows = filtered_file.shape[0]
        if rows > 20:
            filtered_file = filtered_file.iloc[0:20,:] 
        cols = filtered_file.shape[1]
        names = filtered_file.columns.values.tolist()
        value_list = np.array(filtered_file).tolist()

        sort = request.GET.get('sort', "")
        if sort:
            if sort == "huoshan":
                the_file_path = "/static/result/volcano_map.png"

        return render(request, "result_rna1.html", {
            "the_file_path":the_file_path,
            "sort":sort,
            "rows":rows,
            "cols":cols,
            "names":names,
            "value_list":value_list,
        })


class RNAResultsView0(View):
    """
    只有文件的结果页
    """
    def get(self, request):
        the_file_path = "/static/result/filtered_data.csv"
        filtered_file = pd.read_csv('./static/result/filtered_data.csv')
        rows = filtered_file.shape[0]
        if rows > 20:
            filtered_file = filtered_file.iloc[0:20,:] 
        cols = filtered_file.shape[1]
        names = filtered_file.columns.values.tolist()
        value_list = np.array(filtered_file).tolist()

        sort = request.GET.get('sort', "")

        return render(request, "result_rna0.html", {
            "the_file_path":the_file_path,
            "sort":sort,
            "rows":rows,
            "cols":cols,
            "names":names,
            "value_list":value_list,
        })


class ProbResultsView(View):
    """
    文件，火山图，热图结果页
    """
    def get(self, request):
        the_file_path = "/static/result/filtered_data.csv"
        filtered_file = pd.read_csv('./static/result/filtered_data.csv')
        rows = filtered_file.shape[0]
        if rows > 20:
            filtered_file = filtered_file.iloc[0:20,:] 
        cols = filtered_file.shape[1]
        names = filtered_file.columns.values.tolist()
        value_list = np.array(filtered_file).tolist()
        for i in range(len(value_list)):
            for j in range(len(value_list[i])-1):
                value_list[i][j+1] = round(float(value_list[i][j+1]),8)
        sort = request.GET.get('sort', "")
        if sort:
            if sort == "huoshan":
                the_file_path = "/static/result/volcano_map.png"
            if sort == "re":
                the_file_path = "/static/result/heat_map.png"
            if sort == "violin":
                the_file_path = "/static/result/violin.png"
            if sort == "line":
                the_file_path = "/static/result/line.png"

        return render(request, "result_prob.html", {
            "the_file_path":the_file_path,
            "sort":sort,
            "rows":rows,
            "cols":cols,
            "names":names,
            "value_list":value_list,
        })


class DiyVolcanoView(View):
    """
    DIY火山图
    """
    def post(self, request):
        up_color = request.POST.get('up_color')
        down_color = request.POST.get('down_color')
        normal_color = request.POST.get('normal_color')
        shape = request.POST.get('shape')
        method_type = request.POST.get('method_type')
        print(up_color)
        print(down_color)
        print(normal_color)
        print(shape)
        print(method_type)
        filtered_data = pd.read_csv('./static/result/filtered_data.csv')
        if method_type == "For RNAseq data":
            file_in = pd.read_csv('./static/result/file_in.csv')
            draw_volcano_map(file_in,filtered_data,shape,down_color,normal_color,up_color)
            return HttpResponse('{"status":"success","msg":"DIY_1"}', content_type='application/json')
        else:
            after_test = pd.read_csv('./static/result/after_test.csv')
            draw_volcano_map(after_test,filtered_data,shape,down_color,normal_color,up_color)
            return HttpResponse('{"status":"success","msg":"DIY_2"}', content_type='application/json')


class DiyHeatView(View):
    """
    DIY热图
    """
    def post(self, request):
        theme = request.POST.get('theme')
        row_cluster = request.POST.get('row_cluster')
        col_cluster = request.POST.get('col_cluster')
        print(theme)
        print(row_cluster)
        print(col_cluster)
        if row_cluster == "1":
            row_cluster = True
        else:
            row_cluster = False
        if col_cluster == "1":
            col_cluster = True
        else:
            col_cluster = False
        print(row_cluster)
        print(col_cluster)
        draw_heat_map(theme,row_cluster,col_cluster)
        return HttpResponse('{"status":"success","msg":"DIY_heat"}', content_type='application/json')



#----------------------------------------------------------工具函数-----------------------------------------------------

def probdata_preprocess(data_file,n):
    no = []
    for i in range(data_file.shape[0]):
        per_gene_sum = data_file.iloc[i,1:].sum()
        if per_gene_sum < n:
            no.append(i)
    data = data_file.drop(no)
    data = data.reset_index(drop = True)
    return data

def cal_FDR(data_file):
    data_file_sort=data_file.sort_values(by="p_value")
    n = data_file_sort.shape[0]
    col = list(data_file_sort)
    for pv in range(len(col)):
        if col[pv]=='p_value':
            break
    pv_loc = pv
    fdr = [0 for x in range(n)]
    for i in range(n):
        fdr[i] = data_file_sort.iloc[i,pv_loc]*n/(data_file_sort.index[i]+1) 
    data_file_fdr = data_file_sort.join(pd.DataFrame({'FDR':fdr})) 
    return data_file_fdr

def t_test_2001(data_file,if_log2):
    data_file_log2 = data_file
    row_num = data_file.shape[0]
    col_num = data_file.shape[1]
    #log2标准化
    if if_log2 == "0":
        for i in range(row_num):
            for j in range(col_num-1):
                data_file_log2.iloc[i,j+1]=math.log2(data_file.iloc[i,j+1]+1)#log2(value+1)防止变换后为0
    #计算logFC
    fc = [0 for x in range(row_num)]
    control = data_file_log2.iloc[:,1:int((col_num + 1)/2)].mean(axis = 1)
    case = data_file_log2.iloc[:,int((col_num + 1)/2):int(col_num)].mean(axis = 1)
    for i in range(row_num):
        fc[i] = case.iloc[i] - control.iloc[i]
    #计算p_value 和 t
    pv = [0 for x in range(row_num)]
    t = [0 for x in range(row_num)]
    for i in range(row_num):
        ttest = stats.ttest_ind(data_file_log2.iloc[i,1:int((col_num + 1)/2)], data_file_log2.iloc[i,int((col_num + 1)/2):int(col_num)])
        t[i] = ttest[0]
        pv[i] = ttest[1]
    #拼接结果
    data_file_combine = data_file_log2.join(pd.DataFrame({'logFC':fc, 'p_value':pv, 't':t}))
    #把FDR添加进结果
    t_test_result = cal_FDR(data_file_combine)
    return t_test_result


def ks_test_2002(data_file,if_log2):
    data_file_log2 = data_file
    row_num = data_file.shape[0]
    col_num = data_file.shape[1]
    #log2标准化
    if if_log2 == "0":
        for i in range(row_num):
            for j in range(col_num-1):
                data_file_log2.iloc[i,j+1]=math.log2(data_file.iloc[i,j+1]+1)#log2(value+1)防止变换后为0
    #计算logFC
    fc = [0 for x in range(row_num)]
    control = data_file_log2.iloc[:,1:int((col_num + 1)/2)].mean(axis = 1)
    case = data_file_log2.iloc[:,int((col_num + 1)/2):int(col_num)].mean(axis = 1)
    for i in range(row_num):
        fc[i] = case.iloc[i] - control.iloc[i]
    #计算p_value 和 ks
    pv = [0 for x in range(row_num)]
    ks = [0 for x in range(row_num)]
    for i in range(row_num):
        kstest = stats.ks_2samp(data_file_log2.iloc[i,1:int((col_num + 1)/2)], data_file_log2.iloc[i,int((col_num + 1)/2):int(col_num)])
        ks[i] = kstest[0]
        pv[i] = kstest[1]
    #拼接结果
    data_file_combine = data_file_log2.join(pd.DataFrame({'logFC':fc, 'p_value':pv, 'ks':ks}))
    #把FDR添加进结果
    ks_test_result = cal_FDR(data_file_combine)
    return ks_test_result



def draw_volcano_map(input_file,filtered_file,shape,down_c,normal_c,up_c):
    """
    火山图
    """
    if len(input_file.index)==0 or len(filtered_file.index)==0:
        img = plt.imread('./static/images/default_result.jpg')
        plt.imsave('./static/result/volcano_map.png', img)
    else:
        normal_point = input_file[~input_file.iloc[:,0].isin(filtered_file.iloc[:,0])] 
        normal_point['sig'] = 'normal'
        print(normal_point)
        filtered_file.loc[filtered_file.logFC> 0,'sig'] = 'up'
        filtered_file.loc[filtered_file.logFC< 0,'sig'] = 'down'
        print(filtered_file)
        data_file = normal_point.append(filtered_file)
        print(data_file)
        data_file['log(pvalue)'] = -np.log10(data_file['p_value'])
        #绘图
        plt.figure(figsize=(18,10)) 
        plt.title('Volcano Map of DEGs dataset',fontweight='bold',fontsize=30)
        ax = sns.scatterplot(x="logFC", y="log(pvalue)", legend='full',hue='sig', hue_order = ('down','normal','up'), palette=(down_c,normal_c,up_c), data=data_file,marker=shape)
        plt.ylabel('-log(pvalue)',fontsize=20)
        plt.xlabel('logFC',fontsize=20)
        plt.savefig('./static/result/volcano_map.png')


def draw_heat_map(theme,row_clu,col_clu):
    """
    热图
    """
    data_file = pd.read_csv('./static/result/filtered_data.csv')
    if len(data_file.index) == 0:
        img = plt.imread('./static/images/default_result.jpg')
        plt.imsave('./static/result/heat_map.png', img)
    else:
        loc = data_file.shape[1]-4
        data_file.index = data_file.iloc[:,0]
        filtered = data_file.iloc[:,1:loc]
        print(filtered)
        #绘图
        hot = sns.clustermap(filtered, row_cluster=row_clu, col_cluster=col_clu,cmap=theme,figsize=(18,10)).fig.suptitle('Heat Map of DEGs dataset',fontweight='bold',fontsize=30)
        plt.savefig('./static/result/heat_map.png')

def draw_distribution_map():
    """
    分布图：小提琴图和折线图
    """
    file_filtered = pd.read_csv('./static/result/filtered_data.csv')
    file_in = pd.read_csv('./static/result/file_in.csv')
    file_remain = file_in[~file_in[file_in.columns.values.tolist()[0]].isin(file_filtered.loc[:,file_in.columns.values.tolist()[0]])]
    gene_data = file_in.iloc[:,1:file_in.shape[1]]
    gene_filtered = file_filtered.iloc[:,1:file_filtered.shape[1]-4]
    gene_remain = file_remain.iloc[:,1:file_filtered.shape[1]-4]
    # 小提琴图
    plt.figure(figsize=(30,12))   
    plt.subplot(1,2,1)
    plt.title('Box Chart of Original dataset')
    plt.ylabel('Gene Express Value')
    plt.xlabel('Group Name')
    sns.violinplot(data = gene_data, palette="Blues")
    plt.subplot(1,2,2)
    plt.title('Box Chart of DEGs dataset')
    plt.ylabel('Gene Express Value')
    plt.xlabel('Group Name')
    sns.violinplot(data = gene_filtered, palette="Blues")
    plt.savefig('./static/result/violin.png')

    # 折线图
    plt.figure(figsize=(30,12))   
    plt.subplot(2,1,1)
    plt.title('Line Chart of Original dataset')
    plt.ylabel('Gene Express Value')
    plt.xlabel('Index Of Gene')
    control1 = gene_data.iloc[:,0:int(gene_data.shape[1]/2)].mean(axis = 1)
    case1 = gene_data.iloc[:,int(gene_data.shape[1]/2):int(gene_data.shape[1])].mean(axis = 1)
    sns.lineplot(x=[i+1 for i in range(gene_data.shape[0])] , y=list(control1) , label = 'Control')
    sns.lineplot(x=[i+1 for i in range(gene_data.shape[0])] , y=list(case1) , label = 'Case')
    plt.subplot(2,1,2)
    plt.title('Line Chart of DEGs dataset')
    plt.ylabel('Gene Express Value')
    plt.xlabel('Index Of Gene')
    control2 = gene_filtered.iloc[:,0:int(gene_filtered.shape[1]/2)].mean(axis = 1)
    case2 = gene_filtered.iloc[:,int(gene_filtered.shape[1]/2):int(gene_filtered.shape[1])].mean(axis = 1)
    sns.lineplot(x=[i+1 for i in range(gene_filtered.shape[0])] , y=list(control2) , label = 'Control')
    sns.lineplot(x=[i+1 for i in range(gene_filtered.shape[0])] , y=list(case2) , label = 'Case')
    plt.savefig('./static/result/line.png')
    
