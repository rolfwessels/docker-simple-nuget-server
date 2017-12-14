# sed -i -- 's/http.*\"/http:\/\/\*:80\"/g' configuration.json
sed -i -- 's/\"packages\": \".*\"/\"packages\": \"\/packages\"/g' configuration.json
