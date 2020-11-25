```java
//Blob转换成byte[]
	public byte[] blobToByte(Blob blob) throws Exception {
		byte[] bytes = null;
		try {
			InputStream in = blob.getBinaryStream();
			BufferedInputStream inBuffered = new BufferedInputStream(in);
			ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
			byte[] temp = new byte[1024];
			int size = 0;
			while ((size = inBuffered.read(temp)) != -1) {
				out.write(temp, 0, size);
			}
			inBuffered.close();
			in.close();
			bytes = out.toByteArray();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return bytes;
	}
```





1、InputStream --->Blob 

Hibernate提供了一个API

````java
Hibernate.createBlob(new FileInputStream(" image/file path "));
````

#### 2、Blob --->InputStream

Blog本身有一个API：

````java
new Blob().getBinaryStream();	
````

#### 3、byte[ ] --->Blob

Hibernate提供的API：

````java
org.hibernate.Hibernate.Hibernate.createBlob(new byte[1024]);
````

#### 4、Blob --->byte[ ]

````java
private byte[] BlobToBytes(Blob blob) {
    BufferedInputStream bufferedInputStream = null;
	try {
		//利用Blob自带的一个函数去将blob转换成InputStream
		bufferedInputStream = new BufferedInputStream(blob.getBinaryStream());
		//申请一个字节流，长度和blob相同
		byte[] bytes = new byte[(int) blob.length()];
		int len = bytes.length;
		int offset = 0;
		int read = 0;
		while (offset < len//确保不会读过头
			 && (read = bufferedInputStream.read(bytes, offset, len - offset)) >= 0) {
			 //BufferedInputStream内部有一个缓冲区，默认大小为8M，每次调用read方法的时候，它首先尝试从缓冲区里读取数据，
			 //若读取失败（缓冲区无可读数据），则选择从物理数据源（譬如文件）读取新数据（这里会尝试尽可能读取多的字节）放入到缓冲区中，
			 //最后再将缓冲区中的内容部分或全部返回给用户 
			 //也就是说read函数一次性可能读不完，所以可能会分多次读，于是就有了上面的逻辑
				offset += read;
		}
	    return bytes;
	} catch (Exception e) {
		return null;
	} finally {
		try {
			bufferedInputStream.close();
		} catch (IOException e) {
    		return null;
		}
	}
}
````



