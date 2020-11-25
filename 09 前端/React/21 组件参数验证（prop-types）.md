---
title: 组件参数验证（prop-types）   
date: 2019-03-13 09:55:00  
categories: React  
---
**组件库名以前为PropTypes现已弃用改为prop-types**

##### 1、安装依赖包
````
npm install --save prop-types
````
##### 2、使用  (如父组件传入参数跟验证类型不符，浏览器f12会警告提示)
````
import React, { Component } from 'react';
import PropTypes from 'prop-types';//1、引入prop-types组件库

class Comment extends Component {
    //方式一：
    static propTypes = {//2、给组件添加propTypes属性
        comment: PropTypes.object//3、设置传入comment值类型为object
    }

    render() {
        const { comment } = this.props
        return (
            <div className='comment'>
                <div className='comment-user'>
                    <span>{comment.username} </span>：
                </div>
                <p>{comment.content}</p>
            </div>
        )
    }
}

//方式二：官方推荐
//Comment.propTypes = {//2、给组件添加propTypes属性
//    comment: PropTypes.object//3、设置传入comment值类型为object
//}

export default Comment;
````
##### 3、提供的验证类型
````
PropTypes.array
PropTypes.bool
PropTypes.func
PropTypes.number
PropTypes.object
PropTypes.string
PropTypes.node
PropTypes.element
......
````
##### 4、更多使用方式
