import 'bootstrap/dist/css/bootstrap.min.css';
import logo from "./logo.svg";
import "./App.css";
import Home from "./components/Profile/Home";
import {Container,Row, Col, Button} from "react-bootstrap"
import "./index.css";

function App() {
  return (
    <>
      <Container fluid>
        <Row>
          <Col>
            <Home />
            <Button>
              Name
            </Button>
          </Col>
        </Row>
      </Container>
    </>
  );
}

export default App;
