# 差异表达基因分析平台
---

## 前言
###### 代码废铁在学习和整合了一些网上项目资源后，使用Python3、前端框架Djando2和MySQL数据库完成的首个Web项目。在此记录，以方便日后回顾，也希望能遇到有缘人拿去使用或学习。

## 一、平台功能简介
1. 完善的用户功能和用户引导机制。包括用户的注册、登录、密码找回。还有个人中心中修改个人信息、修改密码、更换头像等。该平台账号使用邮箱注册，可通过邮箱或用户名登录，需保证此邮箱的可用性，后期用来接收系统的通知邮件。此外，用户使用的引导流程需要在平台首页显示。
2. 方法展示和方法使用功能。展示常用的差异表达基因筛选方法和指标，并且可以根据被使用次数进行排序。点击方法进入方法详情，详情列表的信息包含对该方法的介绍、对内部处理机制的说明、常用的参数阈值以及要求的数据格式等。用户可以根据页面提示信息进行文件上传，格式检查，参数上传和参数核查等步骤最终得到结果文件。
3. 结果展示和结果下载功能。对于处理得到的结果文件，平台只取其前二十行作为展示，其它展示内容根据用户输入文件的内容进行调整。所有展示文件均可通过页面提示进行下载。用户也可以对相关可视化结果的样式进行自主调整，另行下载。
4. 历史记录机制。对于在登录状态下使用该平台的用户，其个人足迹，包括所用方法的方法编号，使用时间，上传的原文件，处理过程中选取的参数等，都会被记录存储。此类信息均可在用户个人中心中查看，曾经上传过的文件也可在此处点击下载。
5. 良好的用户交互，需要具备完善的错误提示信息以便于用户迅速定位出操作不正确的部分。
6. 平台的数据安全以及用户信息的安全。在用户使用邮箱注册成功后需要通过邮件进行激活操作；在对密码和邮箱进行修改的过程中，相应链接都会采用动态生成的方式发送至用户邮箱；对常见的Web攻击做好防范。

## 二、数据库环境配置
### 安装配置MySQL数据库
[MySQL数据库下载与安装详细教程](https://blog.csdn.net/lala12d/article/details/82743875)
### 使用degs.sql文件创建平台所需的数据库
1. 打开MySQL的command line。
![tu_1](/readme配图/1.png)
2. 输入安装时设置的密码。
![tu_2](/readme配图/2.png)
3. 创建一个用于此项目的数据库demo，使用该数据库，
    通过 “source .sql文件存储路径” 完成数据库表的创建。
    `create database demo;`
    `show databases;`
    `use demo`
    `source d:/degs.sql`
![tu_3](/readme配图/3.png)
4. 查看数据库中的表，若与下图一致则建库完成。
`show tables;`
![tu_4](/readme配图/4.png)

## 三、程序运行环境配置
### Python3.7.3
[python安装教程（Windows系统,python3.7为例）](https://blog.csdn.net/weixin_40844416/article/details/80889165?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)
### 程序依赖包
1. 命令行下进入python安装目录下的Scripts目录中
`cd D:\Python3.7.3\Scripts\`
2. 查看当前已安装的程序包
`D:\Python3.7.3\Scripts>pip list`
```
     Package                Version
    ---------------------- --------
    absl-py                0.8.0
    asn1crypto             0.24.0
    astor                  0.8.0
    astroid                2.3.1
    cffi                   1.12.3
    colorama               0.4.1
    cryptography           2.7
    cycler                 0.10.0
    decorator              4.4.0
    defusedxml             0.6.0
    diff-match-patch       20181111
    Django                 2.2.6
    django-crispy-forms    1.8.1
    django-formtools       2.2
    django-import-export   2.0.1
    django-pure-pagination 0.3.0
    django-ranged-response 0.2.0
    django-reversion       3.0.5
    django-simple-captcha  0.5.12
    django-simpleui        3.9
    entrypoints            0.3
    et-xmlfile             1.0.1
    flake8                 3.7.9
    future                 0.18.2
    gast                   0.2.2
    google-pasta           0.1.7
    grpcio                 1.23.0
    h5py                   2.10.0
    httplib2               0.17.0
    imageio                2.5.0
    isort                  4.3.21
    jdcal                  1.4.1
    jieba                  0.39
    joblib                 0.13.2
    Keras-Applications     1.0.8
    Keras-Preprocessing    1.1.0
    kiwisolver             1.1.0
    lazy-object-proxy      1.4.2
    Markdown               3.1.1
    MarkupPy               1.14
    matplotlib             3.1.0
    matplotlib-venn        0.11.5
    mccabe                 0.6.1
    measure                0.5.1
    mock                   3.0.5
    mpmath                 1.1.0
    networkx               2.3
    numpy                  1.17.2
    odfpy                  1.4.1
    openpyxl               3.0.3
    opt-einsum             3.1.0
    pandas                 0.24.2
    Pillow                 6.0.0
    pip                    20.0.2
    protobuf               3.9.1
    pycodestyle            2.5.0
    pycparser              2.19
    pyflakes               2.1.1
    pylint                 2.4.2
    pylint-django          2.0.13
    pylint-plugin-utils    0.6
    PyMySQL                0.9.3
    pyparsing              2.4.0
    python-dateutil        2.8.0
    pytz                   2019.1
    PyWavelets             1.0.3
    PyYAML                 5.3
    scikit-image           0.15.0
    scikit-learn           0.21.2
    scipy                  1.3.0
    seaborn                0.9.0
    setuptools             45.1.0
    six                    1.12.0
    sklearn                0.0
    sqlparse               0.3.0
    sympy                  1.4
    tablib                 0.14.0
    termcolor              1.1.0
    typed-ast              1.4.0
    virtualenv             16.7.9
    virtualenvwrapper-win  1.2.5
    Werkzeug               0.15.6
    wheel                  0.33.6
    wrapt                  1.11.2
    xlrd                   1.2.0
    xlwt                   1.3.0
```
3. 安装程序包：项目的开发工具是vscode，平时使用的时候安了很多乱七八糟的东西，以上列出的包在这个项目里不是全都能用上，但是需要用的都包含了。可以通过all_packages.txt文件把它们批量安装。
`D:\Python3.7.3\Scripts>pip install -r D:/all_packages.txt`

## 三、总体设计框图和代码结构
### 后端总体设计
![tu_5](/readme配图/5.png)
1. app_users:涉及用户本身的信息，管理用户的登录、退出，用来实现个人信息和使用历史记录的部分。用户注册功能的实现；用户登录功能的实现；密码找回功能的实现；个人中心的功能实现。
2. app_methods:涉及方法本身的信息，管理方法列表展示和方法详情展示。方法列表展示功能的实现；方法详情展示功能的实现；文件检查功能的实现；参数检查功能的实现；结果计算功能的实现。
3. app_results：涉及结果本身的信息，管理结果文件和由结果绘制出来的图片的展示以及下载。结果存储与下载功能的实现。
4. app_operation：为了避免上述三个平行模块之间联系杂乱而增添的上层模块，主要涉及模块间的操作。方法使用次数统计功能的实现；用户使用历史功能的实现。
5. utils：提取出的一些在后端逻辑中常用的功能代码。

### 前端总体设计
![tu_6](/readme配图/6.png)
1. templates：存储各种html文件。
2. static：存储各种静态文件，包括图片、结果文件、css文件和js文件（一些样式文件是从网上找的，不是每个都能用上）。

### 其它文件
1. DEG_analyze2：框架生成的主要部分，可以直接把代码写在它下面，也可以抽离成不同app(应用)使结构更加清楚。
2. log：存储日志。
3. media：用户在登录状态下使用时上传的文件。
4. upload_files：上传文件暂存。
5. manage.py：启动程序。

## 四、程序启动
1. 在命令行中，进入到包含manage.py文件的目录下，启动项目。
`python manage.py runserver`
![tu_7](/readme配图/7.png)
2. 访问 `http://127.0.0.1:8000/`，启动完成。
![tu_8](/readme配图/8.png)



    


