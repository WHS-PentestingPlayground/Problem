from flask import Flask, request, render_template_string, abort

import os

real_flag = os.environ.get("REAL_FLAG")
if real_flag:
    with open("flag.txt", "w") as f:
        f.write(real_flag)

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <h2>SSTI Challenge</h2>
        <p>이름을 입력하면 인사를 해드립니다.</p>
        <form method="GET" action="/greet">
            <input type="text" name="name" placeholder="Your name">
            <button type="submit">Greet Me</button>
        </form>
    '''

@app.route('/greet')
def greet():
    name = request.args.get('name', '')
    # 취약점: 사용자 입력을 템플릿에 직접 렌더링
    template = f"Hello, {name}!"
    return render_template_string(template)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)