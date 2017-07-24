import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lz.common.page.Page;
import com.lz.img.pojo.ImageInfor;
import com.lz.img.service.IImageService;
import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring-*.xml" })
public class ImageTest {
	@Autowired
	private IImageService imageService;
	
	public void test() {
		ImageInfor imageInfor = new ImageInfor();
		Page page = imageService.list(imageInfor);
		System.out.println(page);
		
	}
}
