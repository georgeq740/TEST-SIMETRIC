import grpc
import example_pb2
import example_pb2_grpc

def run():
    with grpc.insecure_channel("servidor-service.default.svc.cluster.local:50051") as channel:
        stub = example_pb2_grpc.ExampleServiceStub(channel)
        response = stub.SayHello(example_pb2.HelloRequest(name="World"))
        print(f"Response from server: {response.message}")

if __name__ == "__main__":
    run()
