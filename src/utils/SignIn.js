state = {
    username: '',
    password: '',
    digicode: '',
    alertMessage: '',
    status: '',
    loggedIn: false
}

onSignIn = async () => {
    console.log("inside sign in");
    if (this.state.username !== '' && this.state.password !== '' && this.state.digicode !== '') {
        let username = this.state.username.trim();
        let password = this.state.password.trim();
        let digicode = this.state.digicode.trim();

        let usernameToSend = username;

        //===
        if (password.length < 8) {
            this.setState({
                alertMessage: "at least 8 characters for password",
                status: 'failed',
                password: '',
                digicode: '',
            });
            return;
        } else {

        } if (digicode.length !== 6) {
            this.setState({
                alertMessage: "6 digit required for digicode",
                status: 'failed',
                digicode: ''
            });
            return
        } else {
            let userAddress = await this.props.contract.methods.getUserAddress()
                .call({ from: this.props.account });

            if (userAddress === '0x0000000000000000000000000000000000000000') {
                this.setState({
                    alertMessage: 'Account does not exists',
                    status: 'failed',
                    username: '',
                    password: '',
                    digicode: '',
                });
                return;
            } else {
                let validated = await
                    AuthValidation(
                        username,
                        this.props.account,
                        password, digicode,
                        this.props.web3,
                        this.props.contract
                    );

                if (!validated) {
                    this.setState({
                        alertMessage: 'Incorrect log in',
                        status: 'failed',
                        username: '',
                        password: '',
                        digicode: '',
                    });
                    return
                } else {
                    this.setState({
                        username: '',
                        password: '',
                        digicode: '',
                        status: 'success',
                        alertMessage: "Sign in successful",
                        loggedIn: true
                    });

                    this.props.userSignedIn(
                        this.state.loggedIn,
                        usernameToSend
                    );

                    return;
                }
            }
        }
    }


    this.setState({
        username: '',
        password: '',
        digicode: ''
    })
}