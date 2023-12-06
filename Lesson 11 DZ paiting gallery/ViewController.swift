import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var imageNames = ["1", "2", "3"] // создаем масив
    var currentImageIndex = 0 // переменная 0 - начальный индекс массива будет использоваться в ветвлениях

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the initial image
        displayImage(imageNames[currentImageIndex]) // показ изображения на экране с выбранным индексом
    }

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        currentImageIndex += 1 // индекс принимает значение +1 по каждому нажатию
        if currentImageIndex >= imageNames.count { // если в интекс больше количества элементов массива устанавливается начальный индекс 0 что листании было бесконечным
            currentImageIndex = 0
        }
        slideImages(fromRight: true) // устанавливается состояние листании вперед или назад если Tru вперед
    }

    @IBAction func rightButtonPressed(_ sender: UIButton) {
        currentImageIndex -= 1
        if currentImageIndex < 0 {
            currentImageIndex = imageNames.count - 1
        }
        slideImages(fromRight: false)
    }

    func displayImage(_ imageName: String) {
        imageView.image = UIImage(named: imageName) // функция отображения текущий view с номером массива который постоянно меняется
    }

    func slideImages(fromRight: Bool) {
        let nextImageIndex = currentImageIndex + (fromRight ? 1 : -1)

        var nextImageName: String

        if nextImageIndex >= imageNames.count {
            nextImageName = imageNames[0] // Loop back to the first image
        } else if nextImageIndex < 0 {
            nextImageName = imageNames[imageNames.count - 1] // Loop back to the last image
        } else {
            nextImageName = imageNames[nextImageIndex]
        }

        // Create a new image view with the next image
        let nextImageView = UIImageView()
        nextImageView.image = UIImage(named: nextImageName) // создаем по обработанному имени изображения выше
        nextImageView.frame = CGRect(x: fromRight ? view.frame.width : -view.frame.width,
                                     y: imageView.frame.origin.y,
                                     width: imageView.frame.width,
                                     height: imageView.frame.height)

        view.addSubview(nextImageView) // добавить за рамку следующее изображение в зависимости от fromRight

        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.frame.origin.x = fromRight ? -self.view.frame.width : self.view.frame.width // текущее изображение уезжает в зависомости в от fromRight в лево или правл
            nextImageView.frame.origin.x = 0 // созданное следующее изображение устанавливается на 0 в центр экрана - выездает по анимации
        }, completion: { _ in
            self.imageView.removeFromSuperview() // удаляем станое  view котрое уже за экраном
            self.imageView = nextImageView // присванием view nextImageView
            self.currentImageIndex = nextImageIndex // обновляем индекс массива
        })
    }
}
