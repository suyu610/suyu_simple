// 一个消息的状态
enum MsgStatus {
  // 服务器已接收到
  isSent,
  // 发送中
  Sending,
  // 已发送，但是服务器没接收到
  Failed,
  // 如果发送是二进制内容，则会有上传中状态
  Uploading,
  // 如果是接收二进制内容，则会有下载中  
  DownLoading,
}
