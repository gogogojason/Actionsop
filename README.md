

### 星标 `star` 编译

- yml文件打开注释点击 **star** (星标开始全部编译)；依赖这句判断是仓库持有者点击:`github.event.repository.owner.id == github.event.sender.id`

```yml
watch:                     # 监视操作
    types: started         # 点击 star 之后,可以写数组形式，具体可以参考官方文档
```

### 定时 `schedule` 编译

- 定时编译方法 [GitHub 官方文档](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)
- 编译模板 yml 文件中有个每天北京时间凌晨 3 点编译的例子

```yml
schedule:                 # 时间表
  - cron: "0 19 * * *"    # 每天国际时间 19 点，北京时间 3 点执行(北京+8)
```

## 目录说明

```json
  |-- .editorconfig     # 编辑规范
  |-- .github           # GitHub 工作目录
  |   |-- workfloms     # 存放 Action 的 YML文件
  |-- openwrt           # openwrt 有关
  |   |-- backups       # openwrt 文件备份 以及 openwrt 编译模板
  |   |-- public.sh      # 公共的修改执行文件
  |-- padavan           # padavan 有关
  |   |-- backups       # padanvan文件备份 以及 padavan 编译模板
  |   |-- public.sh     # 公共的修改执行文件
  |-- screenshots       # 效果目录
```

## Action 常用参数说明

> - name 自动构建的名字
> - on 触发条件
>
>   - schedule:                 # 时间表
>     - cron: '0 19 \* \* \*'   # 每天国际时间 19 点，北京时间凌晨 3 点执行(北京+8)
>   - watch                     # 监视
>     - type: started           # 类型：点击了星标
>
> - env 环境变量
> - jobs 任务
> - build 工作的 id
> - run-on 工作运行的环境平台
> - if 工作运行的判断
> - steps 包含一系列任务步骤
>   - name 子任务名
>   - user 使用官方的一些库完成一些操作
>   - run 运行脚本
>   - id 运行 id
