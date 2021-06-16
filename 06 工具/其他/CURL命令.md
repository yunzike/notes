基本格式

```bash
curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
```

| 部件         | 说明                                                         |
| ------------ | ------------------------------------------------------------ |
| VERB         | 适当的 HTTP 方法 或 谓词：`GET`、`POST`、`PUT`、`HEAD` 或者 `DELETE` |
| PROTOCOL     | `http` 或者 `HTTPS`                                          |
| HOST         | 主机名，或者用 `localhost` 代表本机                          |
| PORT         | 端口                                                         |
| PATH         | `API` 的路径                                                 |
| QUERY_STRING | 任意可选的查询字符串参数 (例如 `?pretty` 将格式化地输出 `JSON` 返回值，使其更容易阅读) |
| BODY         | 一个 `JSON` 格式的请求体 (如果请求需要的话)                  |

