from flask import Flask, render_template

# create_app wraps the other functions to set up the project

def create_app(config=None, testing=False, cli=True):
    """
    Application factory, used to create application
    """
    app = Flask(__name__, static_folder=None)

    @app.route('/')
    @app.route('/index')
    def index():
        user = {'username':'David'}
        return render_template('index.html', title='Home Page', user=user)

    return app
