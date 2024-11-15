
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let buttonPlus = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        // 뷰의 배경색 설정
        view.backgroundColor = .black
        
        // 입력을 보여주는 label
        label.text = "12345"
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 60)
        
        // button 생성
        button7.setTitle("7", for: .normal)
        button8.setTitle("8", for: .normal)
        button9.setTitle("9", for: .normal)
        buttonPlus.setTitle("+", for: .normal)
        
        // button setting 적용
        [button7, button8, button9, buttonPlus]
            .forEach { buttonSetting(button: $0) }
        
        // stackView 생성
        let stackView = makeHorizontalStackView([button7, button8, button9, buttonPlus])
        
        // view에 컴포넌트들 추가
        [label, stackView]
            .forEach { view.addSubview($0) }
      
        // label의 오토레이아웃
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(200)
        }
        
        // stackview의 오토레이아웃
        stackView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.top.equalTo(label.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // 반복되는 버튼을 세팅을 적용하는 메서드
    func buttonSetting(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        button.frame.size.height = 80
        button.frame.size.width = 80
        button.layer.cornerRadius = 40
    }
    
    // stackView 생성하는 메서드
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views )
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }
}


//#Preview {
//    ViewController()
//}
