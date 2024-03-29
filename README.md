# AWS

https://aws.amazon.com/ko/console/
계정 생성

AWS에서 서버를 생성하는 방법

1.  마우스 클릭으로 서버 생성
2.  명령어를 사용하여 서버 생성
3.  테라폼을 사용하여 서버 생성

위 방법 중 테라폼을 사용하여 서버를 생성 하는 방법을 해보겠다.

---

> ### AWS 회원가입

[AWS 회원가입](https://aws.amazon.com/ko/console/)

위 링크 접속하여 회원가입 진행

- GMail 계정이 하나만 있지만 아이디가 여러개 필요할 경우  
   a@gmail.com 이라는 계정이 있다고 가정을 하면  
   a+aws@gmail.com  
   a+aws1@gmail.com  
   a+aws2@gmail.com 등...  
   이렇게 하나의 Gmail 계정 하나로 여러개의 AWS 계정 생성이 가능하다.

#### IAM

- 사용자와 권한을 관리하는 서비스

예를 들어
AWS를 사용하는 회사에 여러 팀이 존재한다.

- 프론트 팀
  - 서버 1, 2 관리
  - 액세스 권한
- 백엔드 팀
  - 서버 3, 6 관리
  - 액세스 권한
- 인프라 팀
  - 서버 1, 2, 3, 4, 5, 6 관리
  - CRUD 권한
- 회계 팀
  - 1, 2, 3, 4, 5, 6
  - 요금 관련에 접급 권한

등 각 각 필요한 권한에 맞게 그에 맞는 다양한 권한이 존재한다.

root 계정을 모두 같이 공유를 해서 사용한다면 다양한 문제가 발생될 가능성이 있다.  
그래서 root 계정을 통해서 다양한 하위 계정을 만들어 각 계정에 필요한 권한을 설정하여 사용

AWS 사용 주의사항
비용/결제 , IAM 설정은 글로벌 서비스이다.  
위 서비스를 제외 한 모든 서비스는 지역 서비스 이기 때문에 추가적인 요금 발생을 하지 않기위해 주의!

root 계정에서 파생된 계정에 로그인을 하기위해서는 어떤 계정에서 생성한 계정인지 확인을 하기 위해서 구분코드가 생성되어 로그인 시 추가적인 입력이 필요하다.  
개인적으로 구분코드를 사용하여 로그인을 하는 방법 보다는 해당 계정에 별칭을 생성 후 사용 하는 방법이 편하다고 생각하기 때문에 별칭을 생성했다.

- 리전 `Region`  
  인프라를 지리적으로 나누어 배포하는 것을 의미한다.  
  즉, 쉽게 말을하면 나라별 단위?

      `IAM`은 글로벌 서비스이기 때문에 특정 리전에 귀속하지 않는다.
      하지만 `IAM`을 제외한 대부분의 서비스는 특정 리전에 귀속이 된다.

- 가용 영역 `Availability Zone`  
  하나의 리전에는 최소 2개의 데이터 센터가 있고 리전 내 각각의 가용 영역은 고속 네트워크로 연결되어 있다.  
  해당 리전 내 존재하는 가용 영역은 서로 물리적으로 격리되어 있다.

- VPC `Virtual Private Cloud`  
  AWS에서 무억을 만들려고 한다면 무조건 하나의 VPC가 있어야 가능하다.
  VPC는 가용 영역에 귀속되는 것이 아닌 리전에 귀속이 된다.

      * 10.0.0.0/ 16
           10.0.0.0/ 255.255.0.0 이거랑 같은 말이다.
          즉, 네트워크에서 관리가능한 IP의 개수 : 255*255 개
          10.0.0.0/ 11111111.11111111.00000000.00000000 (1은 영역은 건들 수 없는 영역, 0부터 수정이 가능한 영역)
          10.0.0.0 ~ 10.0.0.255, 10.0.1.0 ~10.0.255.255 까지의 IP를 사용 할 수 있다.

      * 10.0.0.0/ 24
          10.0.0.0/ 255.255.255.0
          네트워크에서 관리하는 IP 개수 : 255개
          10.0.0.0/ 11111111.11111111.11111111.00000000
          10.0.0.0/ 24 -> 작은 네트워크

      * 서브넷
      IP 주소의 범위를 뜻 한다.
      간단히 설명을 한다면 VPC에서 IP주소를 파티션으로 나눠서 사용한다?

      * EX
          10.0.0.0/ 16 VPC를 만들고
          서브넷 설정으로 10.0.0.0/ 24, 10.0.1.0/ 24 이렇게 한다면

          VPC는 총 65,536개의 IP주소를 갖고있고
          서브넷은 10.0.0.0/24, 10.0.1.0/24 각 256개의 IP를 사용한다.

vpc는 전체 네트워크를 집이라고 생각하면 서브넷은 방이라고 이해를 하면 된다.

> ### AWS CLI

- AWS CLI 설치

  - 윈도우 사용자  
    [AWS CLI 설치](ttps://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html)

  - MAC 사용자  
    ` Command line installer - All users`

- 설치 확인

설치 완료 후 콘솔에서 로그인을 하고 싶은 경우 해당 계정의 엑세스 키를 생성을 해야한다

보안 자격 증명 -> 액세스 키 생성

액세스 키 노출 시 심각한 문제가 발생되니 주의

- 로그인

- AWS 엑세스키가 등록되어 있는지 확인

  ```bash
  aws configure list
  ```

- AWS 액세스 키 등록 (로그인)

  ```bash
  aws configure
  ```

  `ap-northeast-2` 은 AWS 서울 의미한다.

  ```bash
  AWS Access Key ID [None]: 액세스 키
  AWS Secret Access Key [None]: 액세스 비밀 키
  Default region name [None]: ap-northeast-2
  Default output format [None]:
  ```

  위 과정을 수행 후

  ```bash
  aws s3 ls
  ```

  입력 후 아무 결과가 안나오면 성공!

- 액세스 키 삭제하는 방법

  `콘솔 접속 -> 해당 유저 선택 -> 보안자격증명 -> 액세스 키 -> 비활성화 -> 삭제`

- AWS CLI에 입력된 액세스 삭제하는 방법

  - 위도우
    - 터미널
    ```bash
    rmdir /s /q "%USERPROFILE%/.aws"
    ```
    - 파워 쉘
    ```bash
    rm -force -recurse $HOME\.aws
    ```
  - Mac
    ```bash
    rm -rf ~/.aws
    ```

- #### 테라폼 CLI 설치
  [테라폼 CLI 설치](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

설치 후 환경변수 등록 진행

설치 확인을 위해 `cmd`를 열어서

```bash
terraform
```

입력을 하면 확인이 가능하다

나느 인텔리제이를 이용하여 관리를 할려고 한다. 그래서 인텔리제이에 테라폼 플러그인 설치

기존에 만들었던 vpc는 다시 삭제하였다.

테라폼 명령어

```bash
terraform init
// 라이브러리 다운로드
// 라이브러리 소스코드 변경이 있을 때 마다 실행

terraform plan
// 실제 리소스 생성을 하는것이 아닌
// 현재 소스코드의 실행 가능여부 검사

terraform apply
// 리소스 생성

terraform destroy
// 리소스 삭제
```

main.ft파일을 만들어 코드를 입력한 후
위 명령어를 이용하여 vpc 생성이 가능하다.
그리고 `terraform destroy`입력하여 다시 삭제를 진행 했다.

vpc 는 리전에 대응되고
서브넷은 해당 vpc 리전 안에 있는 가용영역에 대응된다.

기본적은 `.tf` 파일들은 자바와 같이 별도의 임포트 문 없이 사용이 가능하다.

AWS를 만들 때 아래 두개의 설정은 해줘야 한다.

```java
  // DNS 지원을 활성화
  enable_dns_support   = true
  // DNS 호스트 이름 지정을 활성화
  enable_dns_hostnames = true
```

DNS 지원 활성화: 이 설정을 활성화하면 VPC 내에서 DNS 서비스가 활성화가 된다. 이는 각 인스턴스에게 자체적인 DNS 이름이 부여되어 네트워크에서 호스트 이름을 사용하여 통신할 수 있게 됩니다. 예를 들어, EC2 인스턴스가 "web-server-1"이라는 호스트 이름을 가지고 있다면, 다른 인스턴스는 이 호스트 이름을 사용하여 해당 인스턴스에 쉽게 액세스할 수 있습니다.

DNS 호스트 이름 지정 활성화: 이 설정을 활성화하면 EC2 인스턴스에 자동으로 DNS 호스트 이름이 지정됩니다. 이것은 인스턴스의 호스트 이름을 통해 네트워크에서 인스턴스에 쉽게 접근하고 관리할 수 있도록 도와줍니다. 예를 들어, "web-server-1"이라는 호스트 이름을 가진 인스턴스는 해당 이름으로 다른 리소스와 통신할 수 있습니다.

이후 서브넷 생성은 ChatGPT에게 물어봐서 생성을 했다.

VPC에서 인터넷이 되려면 인터넷 게이트웨이가 필요하기 때문에 해당 게이트웨이도 만들었다.

```java
// AWS 인터넷 게이트웨이 리소스를 생성하고 이름을 'igw_1'로 설정
resource "aws_internet_gateway" "igw_1" {
  // 이 인터넷 게이트웨이가 연결될 VPC를 지정. 여기서는 'vpc_1'를 선택
  vpc_id = aws_vpc.vpc_1.id

  // 리소스에 대한 태그를 설정
  tags = {
    Name = "${var.prefix}-igw-1"
  }
}
```

위 코드를 추가한 후 `terraform apply` 명령어를 실행시키면 추가적인 부분만 따로 추가를 해준다.

VPC에서 인터넷이 되도록 설정을 할려면 인터넷 게이트웨이가 필요하다.
그리고 해당 게이트웨이는 라우팅 테이블에 의해서 특정 서브넷에 연결되어야만 동작을 한다.

라우팅 테이블은 단순히 서브넷 안에서의 통신 룰 이라고 생각을 하면 된다.

나중에 EC2 사용을 위해서 일단은 모든 것에 대하여 허용이 되는 필터 생성

- EC2는 무조건 보안 필터가 있어야한다.
- 보안 필터는 들어오고, 나가는 패킷을 IP,포트 기준으로 필터링을 한다.

---

EC2

NCP 같은 경우에는 로그인 할 때 아이디/비밀번호가 필요했다.  
기본적으로 아이디와 비밀번호로 ssh로의 접속이 가능했다.  
하지만, AWS에는 이런 방식을 추천하지 않는다. AWS에서는 서버를 만들 때 마다 key 파일을 하나 만들어 준다. 그걸 이용하여 아이디/ 비밀번호 없이 접속이 가능하다. 그런데 이런 방법은 귀찮으 방법이다.  
그래서 향상된 방법이 하나 있다.  
이 방법을 이용하기 위해서는 EC2가 해당 방법 사용에 대한 권한이 있어야 가능하다. (리소스도 권한을 갖을 수 있다.)

- EC2는 특정 서브넷에 속한다.
- 키 파일 없이 AWS 콘솔에서 바로 EC2에 SSH 접속을 하려면 해당 EC2가 AmazonEC2RoleforSSM 권한을 갖고 있어야 한다.
- 보통 EC2는 S3에 대한 권한을 갖는게 보통이다.

EC2-1에 접속하여

- docker 설치 및 실행

```shell
    yum install docker -y
    systemctl start docker
    systemctl enable docker
```

- docker 컴포즈 설치

```shell
  curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  # 최신 docker compose를 해당 링크에서 받을 수 있음
  chmod +x /usr/local/bin/docker-compose
  # 권한 부여
  docker-compose version
  # 설치 확인
```

- Git 설치
  ```shell
    yum install git
    # Git 설치
  ```

위 3가지 설치 후
소스코드를 받을 폴더를 생성 후 git clone을 통해서 간단한 Hello World!를 나타내는 프로젝트를 받았다.

하지면 여기서 용량이 부족하여 30GB로 용량을 늘렸다.
( 볼륨을 수정 할 때 인스턴스 동작을 중지 한다.)

추가적으로 swapfile 생성

Swapfile
AWS EC2 프리티어에서 메모리는 1GB 크기이다. 이 상태로 무엇인가 진행을 할려고 하면 메모리 부족 현상이 발생된다.
이 현상을 막기 위해서는 나는 `swapfile`을 이용 할 생각이다.

리눅스에서는 Swapping이라는게 존재하는데 이는 하드디스크를 가상 메모리로 전환시켜 사용하는 방식이다.

- 생성

```shell
# dd 명령을 사용하여 루트 파일 시스템에 스왑 파일을 생성
$ sudo dd if=/dev/zero of=/swapfile bs=128M count=32
# 스왑 파일의 읽기 및 쓰기 권한을 업데이트
$ sudo chmod 600 /swapfile
# Linux 스왑 영역을 설정
$ sudo mkswap /swapfile
# 스왑 공간에 스왑 파일을 추가하여 스왑 파일을 즉시 사용할 수 있도록 설정
$ sudo swapon /swapfile
# 프로시저가 성공적인지 확인
$ sudo swapon -s
# 파일을 편집하여 부팅 시 스왑 파일을 시작
$ sudo vi /etc/fstab
#  파일 마지막 줄에 아래의 줄 추가 후 저장
#  /swapfile swap swap defaults 0 0
```

도커 이미지 생성

---

지금까지의 작업을 모두 한번에 Terraform으로 자동화
