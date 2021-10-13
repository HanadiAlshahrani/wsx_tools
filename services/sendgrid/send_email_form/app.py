import os

from flask import Flask, render_template, request
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

from logic import check_api_tokens, send_sendgrid_email

## Configuration:
## In Accepted Tokens, provide the NAMES of keys in .secrets
## that you want to have access to your tool.
accepted_tokens = ['DerricksToken1234', 'NiharsToken1234']

# App Logic
app = Flask(__name__)

@app.route('/')
def index():
    return render_template('form.html')

@app.route('/send_email')
def form_submit():
    to_email = request.args.get('to_email')
    from_email = request.args.get('from_email')
    subject = request.args.get('subject')
    content_to_send = request.args.get('content_to_send')
    api_token = request.args.get('api_token')

    if check_api_tokens(api_token, accepted_tokens):
        response = send_sendgrid_email(from_email, to_email, subject, content_to_send, sendgrid_api_token)
        html_string = "<h2>" + str(response) + "</h2>"
        return html_string

    else:
        return "<h3>Form Invalid</h3>"


if __name__ == '__main__':
    app.run()
