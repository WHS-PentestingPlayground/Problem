from flask import Flask, send_file, request
import os

app = Flask(__name__)

@app.route('/')
def index():
    # file 파라미터로 이미지 파일명을 받아서 취약하게 렌더링
    img_file = request.args.get('file', 'santorini.jpg')
    img_tag = f'<img src="/view?file={img_file}" alt="Santorini" style="max-width: 500px; border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.2); margin: 24px 0;">'
    html = f'''
    <html>
    <head>
        <title>Atlantis Santorini</title>
        <style>
            body {{
                font-family: 'Segoe UI', Arial, sans-serif;
                background: url('/view?file=Santorini.png') no-repeat center center fixed;
                background-size: cover;
                color: #222;
                padding: 40px;
                text-align: center;
            }}
            .container {{
                background: rgba(255,255,255,0.85);
                border-radius: 20px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.08);
                max-width: 600px;
                margin: 40px auto;
                padding: 32px 24px;
            }}
            h1 {{
                color: #2d5fa4;
                margin-bottom: 12px;
            }}
            p {{
                font-size: 1.1em;
                line-height: 1.7;
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Santorini</h1>
            <p><strong>Santorini</strong> is a breathtaking island located in the southern <em>Aegean Sea</em> of Greece, famous for its <strong>white-washed houses</strong>, <strong>blue-domed churches</strong>, and <em>spectacular sunsets</em>.<br>
            Often referred to as the <strong>lost city of Atlantis</strong> by some historians, this globally renowned tourist destination offers a <em>romantic atmosphere</em> and <strong>stunning landscapes</strong> that captivate visitors from around the world.</p>
        </div>
    </body>
    </html>
    '''
    return html

@app.route('/view')
def view():
    filename = request.args.get('file')
    base = os.path.basename(filename)
    diff = filename.replace(base, '')

    if diff == '../':
        return 'no hack', 400
    file_path = os.path.join('downloads', filename)
    return send_file(file_path, as_attachment=False)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')