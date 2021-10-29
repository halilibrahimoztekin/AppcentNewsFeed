# AppcentNewsFeed 
## Neler Yaptım?
1.Article ve Source adında iki adet model oluşturdum ve bunları articlelistviewmodel ve articleviewmodel viewmodellerimle birbirine bağladım. 

2.Webservice classımı oluşturdum. Burada URLComponent fonksiyonu ve URLsession fonksiyonlarını kullanarak verimi aldım. 

3.Aldığım veriyi  articlelist halinde JsonDecode ettim.. 

4.FeedviewController üzerinde web servisim üzerindeki veriyi çağırarak feeds değişkenime eşitledim. 

5.Gelen verileri index numarasına göre cellForRowAt ile listeledim. Burada elimdeki listeyi tek bir modele göre ayrıştırdım ve veri görüntülemeyi buna göre sağladım.

6.Seçim yapıldığında segue aracılığıyla detailsviewcontroller ekranına bu modeli gönderdim ve orada da detaylı bir şekilde görüntülenmesini sağladım. 

7.Detay ekranına gelindiğinde seçilmiş ekran "Feed" stringi de iletildiyse verinin FeedViewController üzerinden geldiğini anladım ve listelememi de ona göre yaptım. 

8.Kullanıcı favoriye ekleme işlemi yaptığında bunu Core Data kullanarak kaydettim ve ardından Notification paketiyle core dataya veri eklendiğini diğer controllerlere bildirdim

9.Bu bildiri aracılığıyla favoriler ekranını yeniledim ve eklenin verinin orada da görüntülenmesini sağladım. 

10.Bu listeden detay sayfasına giden isteklerde ise bunu yine değişken aracıloığıyla anlayıp core daha üzerinden tıklanan veriyi listeledim.

11.Kullanıcıya haberin içeriğini tam okumayı istemesi halinde webview ile görüntüleme yapabileceği bir View Controller ekledim. 

12.Detay sayfasındayken kullanıcı News Source butonuna tıkladığında urlyi almakta ve webview controller sayfasında görüntülemekte. 

13.Resim linklerini görüntüleyebilmek için açık kaynaklı bir kütüphane olarak SDWebImage kullandım. 

14.Geliştirme aşamasında MVVM design patternine sadık kalmaya çalıştım. 

<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss8.png" alt="drawing" style="width:300px;"/>
<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss2.png" alt="drawing" style="width:300px;"/>
<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss3.png" alt="drawing" style="width:300px;"/>
<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss4.png" alt="drawing" style="width:300px;"/>
<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss5.png" alt="drawing" style="width:300px;"/>
<img src="https://github.com/halilibrahimoztekin/AppcentNewsFeed/blob/main/ss/ss6.png" alt="drawing" style="width:300px;"/>
