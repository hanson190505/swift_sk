//
//  ContentView.swift
//  todo
//
//  Created by 张莎 on 2021/6/2.
//

import SwiftUI

struct ContentView: View {
    @State private var remoteImage : UIImage? = nil //该属性拥有@State标记，所以当该属性的值发生变化时，和改属性绑定的图像视图，将立即显示新的图像内容
        let placeholderOne = UIImage(named: "Picture") //占位图
        
        var body: some View {
            Image(uiImage: self.remoteImage ?? placeholderOne!) //如果网络图片属性的值不为空，则显示下载后的网络图片，否则显示占位符图片
                .onAppear(perform: fetchRemoteImage) //当图片显示之后，将立即执行下载网络图片的方法
        }
        
        func fetchRemoteImage() //用来下载互联网上的图片
        {
            guard let url = URL(string: "http://hdjc8.com/images/logo.png") else { return } //初始化一个字符串常量，作为网络图片的地址
            URLSession.shared.dataTask(with: url){ (data, response, error) in //执行URLSession单例对象的数据任务方法，以下载指定的图片
                if let image = UIImage(data: data!){
                    self.remoteImage = image //当图片下载成功之后，将下载后的数据转换为图像，并存储在remoteImage属性中
                }
                else{
                    print(error ?? "") //如果图片下载失败之后，则在控制台输出错误信息
                }
            }.resume() //通过执行resume方法，开始下载指定路径的网络图片
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
