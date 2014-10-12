# 推送


## run

首先取到token，然后再gulpfile.js里替换myDevice值

然后只需

```
gulp apns 
```


密码123456



## date picker


```
	<script src="vendor/datetimepicker/js/moment-with-locales.min.js"></script>
	<script src="vendor/datetimepicker/js/bootstrap-datetimepicker.min.js"></script> 
```

说明

- 注意顺序，不然会报错
- http://momentjs.com/  Parse, validate, manipulate, and display dates in javascript.
	
	
## 

定时任务

- 定时
- 实时

## api



### url

/api/v1/push_service/add.json

### param

- from{
		device_token：
		user：
	}
- to_device_token{
		device_token：
		user：
	}
- time_info{
		type: 0实时|1延时,
		send_time: timestamp
	}
- msg_body


场景1


场景2


### 返回结果

{
	data:[],
	status:{
		code : 0,
		msg	 : 'success'
	}
}





