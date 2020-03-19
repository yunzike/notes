
/*

  react路由的配置：
    1、找到官方文档 https://reacttraining.com/react-router/web/example/basic

    2、安装  cnpm install react-router-dom --save


    3、找到项目的根组件引入react-router-dom

       import { BrowserRouter as Router, Route, Link } from "react-router-dom";

    4、复制官网文档根组件里面的内容进行修改  （加载的组件要提前引入）


         <Router>

                <Link to="/">首页</Link>

                <Link to="/news">新闻</Link>

                <Link to="/product">商品</Link>


               <Route exact path="/" component={Home} />
               <Route path="/news" component={News} />    
               <Route path="/product" component={Product} />   
         </Router>


         exact表示严格匹配
         
*/



import React, { Component } from 'react';

import { BrowserRouter as Router, Route, Link } from "react-router-dom";


import './assets/css/index.css'

import Home from './components/Home';
import News from './components/News';
import Product from './components/Product';

class App extends Component {

  render() {
    return (
        <Router>
          <div>           

              <header className="title">
              
                <Link to="/">首页</Link>

                <Link to="/news">新闻</Link>

                <Link to="/product">商品</Link>

              </header>


               <br />
               <hr />
      
               <br />
      
      
              <Route exact path="/" component={Home} />
              <Route path="/news" component={News} />    
              <Route path="/product" component={Product} />                 
          </div>
      </Router>
    );
  }
}

export default App;
