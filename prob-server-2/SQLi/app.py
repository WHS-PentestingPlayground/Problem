from flask import Flask, request, render_template_string
import pymysql
import os

app = Flask(__name__)

def get_db_connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        user=os.getenv('DB_USER', 'root'),
        password=os.getenv('DB_PASSWORD', ''),
        database=os.getenv('DB_NAME', 'sqli_lab'),
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

def is_safe(s):
    black = [
        "select", "union", " or ", " and ", "sleep", "benchmark", "--", "#",
        "=", " like ", "regexp", "substr", "substring", "char", "ascii", "hex",
        "information_schema", "flag", "file", "into", "outfile"
    ]
    s_lower = s.lower()
    return not any(x in s_lower for x in black)

@app.route("/", methods=["GET", "POST"])
def index():
    message = ""
    if request.method == "POST":
        try:
            username = request.form.get("username", "")
            password = request.form.get("password", "")

            if not is_safe(username) or not is_safe(password):
                message = "차단된 단어가 포함되어 있습니다."
            else:
                conn = get_db_connection()
                cursor = conn.cursor()

                query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
                cursor.execute(query)
                result = cursor.fetchone()

                if not result:
                    message = "로그인 실패"
                elif result.get('username') == 'admin':
                    with open("flag.txt") as f:
                        flag = f.read()
                    message = f"플래그: {flag}"
                else:
                    message = f"환영합니다, {result.get('username', '유저')}"
        except Exception as e:
            message = "서버 처리 중 오류가 발생했습니다."
        finally:
            try:
                cursor.close()
                conn.close()
            except:
                pass  
    return render_template_string('''
        <form method="post">
            ID: <input name="username"><br>
            PW: <input name="password" type="password"><br>
            <button type="submit">로그인</button>
        </form>
        <pre>{{message}}</pre>
    ''', message=message)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

