<%@page contentType="text/html" pageEncoding="UTF-8"%>


       
    
   
        <div class="search-wrapper section-padding-100">
    
    <div class="search-close">
        <i class="fa fa-close" aria-hidden="true"></i>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="search-content">
                    <form action="home" method="GET"><!-- điều hướng servlet url=home -->
                        <input type="hidden" name="search" value="search"/>
                        <input type="search" name="keyword" id="search" placeholder="Type your keyword...">
                        <button type="submit"><img src="img/core-img/search1.png" alt="" ></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

