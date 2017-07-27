import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lz.common.page.Page;
import com.lz.img.pojo.ImageInfor;
import com.lz.img.service.IImageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring-mvc.xml" })
public class ImageTest {
	@Autowired
	private IImageService imageService;
	
	@Test
	public void test() {
		ImageInfor imageInfor = new ImageInfor();
		Page page = imageService.listByPage(imageInfor);
		System.out.println(page.getData().size()); // 默认条数
	}
}
