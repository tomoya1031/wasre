<a href="https://codeclimate.com/github/tomoya1031/wasre/maintainability"><img src="https://api.codeclimate.com/v1/badges/0a4a451f0f27c9613d87/maintainability" /></a>

<img width="1149" alt="スクリーンショット 2020-11-08 15 27 24" src="https://user-images.githubusercontent.com/67405786/98458718-f0b45480-21d6-11eb-8619-63745896502c.png">



# WASRe：



## サイト概要
「共助を育み地域を繋げるオンライン価値交換マーケット」  
地域単位で交流を深めるための物物交換サイトです。

## URL
http://wasre.work/

【ゲストログイン(閲覧用)】ボタンからゲストユーザーとしてログインできます。


## サイトテーマ
この地域限定オンライン価値交換マーケットが地域に浸透することで、ゴミ（無価値）だったものが、宝（価値あるもの）に変わります。  
日本人の心の奥底に眠る「もったいない」、「良いもの長く使い続ける」価値観が再燃して欲しいと考えています。このビジネスプランは、
「手渡しでの交換」と「金銭のやり取りを行わない」ことを特徴としています。  
ポストコロナでも人との繋がりを失わず、お裾分けを行うことで優しさ・共助の精神を育み、あえて金銭のやり取りを行わないことで、
その優しさと共助の精神が金銭価値にすり変わらないようにすることを目的としています。


## テーマを選んだ理由
このコロナ禍の影響で、主要８都市では家庭ゴミが７％増加しましたが、それは全てゴミ（無価値）だったのでしょうか。  
他にも、農家や漁師の方は外食産業や学校給食で使用される予定であった食べ物が多く廃棄されていました。  
そこで、ある人にとっては価値のないものが、物々交換のwebを介することで新しい価値に生まれ変わるのではと思いました。  
万願寺甘とうを作りすぎたから必要な人へ「お裾分け」、じゃあ私からは子供服を必要な人へ「お裾分け」。  
そんな昔からあるが廃れつつある共助の文化を、オンライン上で行うことで、いらなくなったものに新しい価値を与え、
「モノの価値」の最大化、最適化を目指します。  
また、交換できる範囲を周辺地域に限定することで、失われつつある地域コミュニティーの活性化を目標にしつつ、
対面する人を最小限に抑えることでポストコロナの時代にあった価値交換マーケットを構築します。


## ターゲットユーザ
舞鶴市民


## 主な利用シーン
不要になったものを処分せず再利用させ、地域交流の手段として活用される

【出品者側】  
* 必要の無くなった物を廃棄するのでなく他者に分け与えたいとき
* 誰か知らない人とコミュニケーションをとり交友関係を広げたいとき

【参加者側】  
* ゴミとして扱われる予定の物をお金を発生させず身近に入手したいとき
* 別の業種関係者とコミュケーションをとり人脈を広げたいとき


## 機能一覧
詳細は下記よりご確認ください。

<https://docs.google.com/spreadsheets/d/1Vig38myydpFf6p2FuUNIFcfWJr2X97EB4--Et8M4fwk/edit?usp=sharing>


## 環境・使用技術
### フロントエンド
* Bootstrap 3.3.6
* SCSS
* JavaScript、jQuery、Ajax

### バックエンド
* Ruby 2.5.7
* Rails 5.2.4.3

### 開発環境
* Vagrant
* VirtualBox
* MySQL2

### 本番環境
* AWS (EC2、RDS for MySQL、Route53、CloudWatch)
* MySQL2
* Nginx、 Puma
* Capistranoにより自動デプロイ

### インフラ構成図

![AWSインフラ設計図（上田智也）](https://user-images.githubusercontent.com/67405786/98459341-5572ad80-21dd-11eb-9638-b7fb0193bf28.jpg)


## ER図
![wasre_ER図 (2)](https://user-images.githubusercontent.com/67405786/99954332-e93f9e80-2dc5-11eb-9564-f6b2feb7e763.png)

###  GitHubの統計情報
[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=tomoya1031&layout=compact&langs_count=10)](https://github.com/anuraghazra/github-readme-stats) [![Unlimish's github stats](https://github-readme-stats.vercel.app/api?username=tomoya1031&count_private=true&show_icons=true&theme=buefy)](https://github.com/anuraghazra/github-readme-stats)
