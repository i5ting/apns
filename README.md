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

## 推送对外api接口

推送对外api接口是通用的推送接口

### url

/api/v1/push_service/add.json

### param

- device_token{
		from
		to
	}
- time_info{
		type: 0实时|1延时,
		send_time: timestamp
	}
- msg_info{
		user{
				from
				to
		},
		msg_body{
		
		}
	}

场景1:定时

from_token	:	8ca518a39dd7cd0836fd9f1bcd006ac8cc45b41946bea511933f60d97419ca52
to_token		:	B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F


- device_token{
		from:8ca518a39dd7cd0836fd9f1bcd006ac8cc45b41946bea511933f60d97419ca52
		to:B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F
	}
- time_info{
		type: 1延时,
		send_time: 2014-11-11:10-11
	}
- msg_info{
		user{
			from：user_财神
			to：user_世龙
		},
		msg_body{
			title："您有一封新贺卡"	
			content："今天是密友上线的日子，我特意给你准备了如下祝福。。。。。。。。。。。。。"	
		}
	}

场景2:实时

- device_token{
		from:8ca518a39dd7cd0836fd9f1bcd006ac8cc45b41946bea511933f60d97419ca52
		to:B1504D99F0C0DB8048709EC58BACD4A1054CB331C57627A042E72CE1DFC6873F
	}
- time_info{
		type: 0实时,
		send_time: 2014-11-11:10-11（可选）
	}
- msg_info{
		user{
			from：user_财神
			to：user_世龙
		},
		msg_body{
			title："新回复"	
			content："今天是你的生日，我特意给你准备了如下祝福。。。。。。。。。。。。。"	
		}
	}




### 返回结果

{
	data:[],
	status:{
		code : 0,
		msg	 : 'success'
	}
}





