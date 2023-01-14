state = {
    username: '',
    password: '',
    digicode: '',
    alertMessage: '',
    status: '',
    signedUp: false
}

onSignUp = async () => {
    //this.setState({ signedUp: false });
    console.log("inside sign up");
    if (this.state.username !== '' && this.state.password !== '' && this.state.digicode !== '') {
        let username = this.state.username.trim();
        let password = this.state.password.trim();
        let digicode = this.state.digicode.trim();

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

            if (userAddress !== '0x0000000000000000000000000000000000000000') {
                this.setState({
                    alertMessage: 'this account already exists',
                    status: 'failed',
                    username: '',
                    password: '',
                    digicode: '',
                });

                return;
            } else {
                let hash = await AuthenticationHash(username, this.props.account, password, digicode, this.props.web3);

                await this.props.contract.methods.register(hash).send({ from: this.props.account });

                this.setState({
                    username: '',
                    password: '',
                    digicode: '',
                    status: 'success',
                    alertMessage: "Signup successful",
                    signedUp: true
                });

                this.props.accountCreated(this.state.signedUp);
                return;
            }
        }
    }

}