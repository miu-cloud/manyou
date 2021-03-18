### テーブル！！！

## User
| colum             |  data  |
|:-----             |:----:  |
| name              | string |
| email             | string |
| password_digest   | string |

## Task
| colum             |  data  |
|:-----------------:|:------:|
| title             | string |
| user_id           | bigint |

## Label
| colum             |  data  |
|:-----------------:|:------:|
| title             | string |
| task_id           | bigint |



### Herokuへのデプロイ手順
1. アセットプリコンパイルをする
<br>$ rails assets:precompile RAILS_ENV=production 

1. コミットする
<br>$ git add -A
<br>$ git commit -m "init"

1. Herokuに新しいアプリケーションを作成
<br>$ heroku create

1. Heroku stackを変更する
<br>$ heroku stack:set heroku-18

1. Heroku stackの確認
<br>$heroku stack

1. Heroku buildpackを追加する
<br>$ heroku buildpacks:set heroku/ruby
<br>$ heroku buildpacks:add --index 1 heroku/nodejs

1. Herokuにデプロイをする
<br>$ git push heroku master

1. データベースの移行
<br>$ heroku run rails db:migrate
